class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :user_name

  validates :user_name, uniqueness: true
  # Github username may only contain alphanumeric
  # characters or dashes and cannot begin with a dash
  validates :user_name, friendly_id: true
  validates :user_name, length: { in: 1..39 }
  validates :uid, uniqueness: true
  validates :provider, :uid, :screen_name, :user_name, :avatar_url, presence: true

  has_many :access_tokens
  has_many :messages, as: :publisher
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships
  has_many :bots

  # Has scoped rooms by each authority
  has_many :administer_memberships, -> { administer }, class_name: 'Membership'
  has_many :maintainer_memberships, -> { maintainer }, class_name: 'Membership'
  has_many :member_memberships,     -> { member     }, class_name: 'Membership'
  has_many :administer_rooms, source: :room, through: :administer_memberships
  has_many :maintainer_rooms, source: :room, through: :maintainer_memberships
  has_many :member_rooms,     source: :room, through: :member_memberships

  def avatar_thumbnail_url size = 64
    "#{avatar_url}&s=#{size}"
  end

  def self.uniq_user_name github_user_name
    github_user_name.downcase!
    return github_user_name if User.where(user_name: github_user_name).size == 0
    loop.with_index(2) do |_, i|
      user_name = "#{github_user_name}#{i}"
      return user_name if User.where(user_name: user_name).size == 0
    end
  end

end
