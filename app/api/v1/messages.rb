module V1
  class MessageEntity < Grape::Entity
    expose :id, documentation: {type: Integer, desc: "メッセージID"}
    expose :content, documentation: {type: String, desc: "発言内容"}
    expose :published_at, documentation: {type: DateTime, desc: "発言日時"}
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
        ActionController::Base.helpers.attachment_url(m.profile, :avatar, :fill, 32, 32, format: 'png', fallback: 'default_avatar_32.png')
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
            requires :limit, type: Integer, default: 30
            requires :offset, type: Integer, default: 0
          end
          get do
            room = @user.chattable_rooms.find_by(screen_name: params[:screen_name])
            # TODO: use offset
            messages = room.messages.recent.limit(params[:limit])
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
                present message, with: MessageEntity
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
