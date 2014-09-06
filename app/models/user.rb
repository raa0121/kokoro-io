class User < ActiveRecord::Base

  validates :user_name, uniqueness: true
  # Github username may only contain alphanumeric
  # characters or dashes and cannot begin with a dash
  validates :user_name, format: { with: /[0-9a-zA-Z][0-9a-zA-Z-]+/ }
  validates :screen_name, length: { in: 1..39 }
  validates :uid, uniqueness: true
  validates :provider, :uid, :screen_name, :user_name, :avatar_url, presence: true

  has_many :access_tokens
  has_many :messages, as: :publisher
  has_many :rooms, through: :user_rooms

  def avatar_thumbnail_url size = 64
    "#{avatar_url}&s=#{size}"
  end

  def self.uniq_user_name github_user_name
    return github_user_name if User.where(user_name: github_user_name).size == 0
    loop.with_index(2) do |_, i|
      user_name = "#{github_user_name}#{i}"
      return user_name if User.where(user_name: user_name).size == 0
    end
  end

end
