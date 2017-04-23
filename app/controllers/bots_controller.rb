class BotsController < InheritedResources::Base
  actions :all

  def new
    @bot = Bot.new
    @bot.build_profile
  end

  def create
    @bot = Bot.new(permitted_params)
    @bot.access_token = Bot.generate_token
    @bot.user = current_user
    @bot.profile.available = true
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
    params.require(:bot).permit(:status, profile_attributes: [:display_name, :screen_name])
  end

end
