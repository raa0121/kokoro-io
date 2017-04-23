
module V1
  class Error < Grape::Entity
    expose :message
  end

  class Root < Grape::API
    version 'v1'
    format :json

    helpers RequestHelper

    # Exceptions
    rescue_from Grape::Exceptions::ValidationErrors do |e|
      error!(e, 400)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      error!({message: 'Record not found.'}, 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      # NOTE: Is this status code appropriate?
      error!({message: 'Record invalid.' }, 404)
    end

    rescue_from :all do |e|
      Root.logger.error(e.message.to_s << "\n" << e.backtrace.join("\n"))
      error!({ message: "Server Error"}, 500)
    end

    # API
    mount V1::Rooms
    mount V1::Messages

    # API document
    add_swagger_documentation(
      add_version: true,
      base_path: '/api',
      hide_documention_path: true,
      info: {
        title: 'kokoro.io API document',
        description: 'X-Access-Token ヘッダーにあなたのアカウントのAPIトークンを含めることでAPIへのアクセスを行うことが出来ます。APIトークンはウェブ管理画面の右上メニュー「アカウント情報 > API情報」から確認可能です。また、このページ右上の「Your API token here」の欄にAPIトークンを入力し「Explore」ボタンをクリックすることで、このページの各API説明部分にある「Try it out!」ボタンから実際にAPIを呼び出すことが可能になります。この時、通常のAPI呼び出しと同様、アカウントへの操作が実際に行われますのでご注意ください。'
      },
      doc_version: '1.0.0'
    )
  end
end
