class BotsController < ApplicationController
  before_action :set_bot, only: [:edit, :update, :destroy]

  def index
    @bots = policy_scope(Bot)
  end

  def new
    @bot = Bot.new
    @bot.build_profile
    authorize @bot
  end

  def create
    @bot = Bot.new(bot_params)
    @bot.access_token = Bot.generate_token
    @bot.user = current_user
    @bot.profile.archived = false
    authorize @bot
    if @bot.save
      redirect_to bots_path, notice: t('Bot was successfully destroyed.')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bot.update(bot_params)
      redirect_to @bot, notice: t('Bot was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @bot.destroy
    redirect_to bots_url, notice: t('Bot was successfully destroyed.')
  end

  protected
  def begin_of_association_chain
    current_user
  end

  private
  def bot_params
    params.require(:bot).permit(:status, profile_attributes: [:display_name, :screen_name])
  end

  def set_bot
    @bot = Bot.find(params[:id])
    authorize @bot
  end

end
