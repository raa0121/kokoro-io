module V1
  class MessageEntity < Grape::Entity
    include ActionView::Helpers::AssetUrlHelper
    include Refile::AttachmentHelper
    expose :id, documentation: {type: Integer, desc: "メッセージID"}
    expose :room_id, documentation: {type: String, desc: "ルームID"}
    expose :content, documentation: {type: Integer, desc: "発言内容"}
    expose :avatar, documentation: {type: String, desc: "発言時のアバターURL"} do |m|
      attachment_url(m.publisher, :avatar, :fill, 18, 18, format: 'png', fallback: 'default_avatar_18.png')
    end
    expose :published_at, documentation: {type: DateTime, desc: "発言日時"}
    expose :publisher do
      expose :type do |m|
        m.publisher.publisher_type
      end
      expose :id do |m|
        m.publisher.id
      end
      expose :display_name do |m|
        m.publisher.display_name
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
                publisher: @user.profile,
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
