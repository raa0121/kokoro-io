class BotsController < InheritedResources::Base
  actions :all

  defaults resource_class: Bot.friendly

  def create
    @bot = Bot.new(permitted_params[:bot])
    @bot.access_token = Bot.generate_token
    @bot.status = Bot.statuses['enabled']
    @bot.user = current_user
    create! do |success, failure|
      success.html { redirect_to bots_path }
    end
  end

  def update
    super do |success, failure|
      success.html { redirect_to bots_path }
    end
  end

  protected
  def begin_of_association_chain
    current_user
  end

  private
  def permitted_params
    params.permit(bot: [:bot_name, :screen_name, :status])
  end

end
