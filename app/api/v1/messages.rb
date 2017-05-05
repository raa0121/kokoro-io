require 'time'

module V1
  class MessageEntity < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "メッセージID"}
    expose :filtered_content, as: :content, documentation: {type: String, desc: "発言内容"}
    expose :content, as: :raw_contet, documentation: {type: String, desc: "発言内容（プレインテキスト）"}
    expose :published_at, documentation: {type: DateTime, desc: "発言日時"} do |m|
      m.published_at.iso8601
    end
    expose :room, documentation: {type: Hash, desc: "発言があったルーム"} do
      expose :room_id, as: :id, documentation: {type: Integer, desc: "レコードID"}
      expose :screen_name, documentation: {type: String, desc: "ルームID"} do |m|
        m.room.screen_name
      end
    end
    expose :profile, documentation: {type: Hash, desc: "発言者情報"} do
      expose :type, documentation: {type: String, desc: "発言者の種類（user|bot）"} do |m|
        m.profile.type
      end
      expose :screen_name, documentation: {type: String, desc: "発言者のスクリーンネーム"} do |m|
        m.profile.screen_name
      end
      expose :display_name, documentation: {type: String, desc: "発言者の表示名"} do |m|
        m.profile.display_name
      end
      expose :avatar, documentation: {type: String, desc: "発言時のアバターURL"} do |m|
        ActionController::Base.helpers.attachment_url(m.profile, :avatar, :fill, 40, 40, format: 'png', fallback: 'default_avatar_32.png')
      end
    end
  end

  class Messages < Grape::API

    resource 'rooms' do
      before do
        authenticate!
      end

      segment '/:screen_name' do

        resource 'messages' do
          before do
            authenticate!
          end

          desc 'Returns recent messages in the room.', {
            entity: MessageEntity,
            response: {isArray: true, entity: MessageEntity}
          }
          params do
            optional :limit, type: Integer, default: 30
            optional :before_id, type: Integer
          end
          get do
            room = @user.chattable_rooms.find_by(screen_name: params[:screen_name])

            # messages = room.messages
            # messages = messages.where("id < ?", params[:before_id]) if params[:before_id]
            # messages = messages recent. limit(params[:limit])
            # if params[:before_id]
            #   messages = room.messages.where("id < ?", params[:before_id])
            # else
            #   messages = room.messages
            # end
            # messages = messages.recent.limit(params[:limit])
            messages = room.messages.recent.limit(params[:limit])
            messages = messages.where("id < ?", params[:before_id]) if params[:before_id]

            present messages, with: MessageEntity
          end

          desc 'Creates a new message.', {
            entity: MessageEntity,
            response: {isArray: false, entity: MessageEntity}
          }
          params do
            requires :message, type: String
          end
          post do
            room = @user.chattable_rooms.find_by(screen_name: params[:screen_name])
            if room
              message = room.messages.create(
                profile: @user.profile,
                content: params[:message],
                published_at: Time.now
              )
              if message
                status 201
                message_entity = present message, with: MessageEntity
                ActionCable.server.broadcast room.id, message_entity
                message_entity
              else
                status 400
              end
            else
              status 404
            end
          end

        end

      end

    end
  end
end
