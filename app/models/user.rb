class User < ActiveRecord::Base

  validates :user_name, uniqueness: true
  validates :uid, uniqueness: true
  validates :provider, :uid, :screen_name, :user_name, :avatar_url, presence: true

  def avatar_thumbnail_url size = 64
    "#{avatar_url}&s=#{size}"
  end

end
