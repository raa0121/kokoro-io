class User < ActiveRecord::Base
  # garage

  include Garage::Representer
  include Garage::Authorizable
  property :id
  property :provider
  property :uid
  property :screen_name
  property :avatar_url

  def self.build_permissions(perms, other, target)
    perms.permits! :read
  end

  def build_permissions(perms, other)
    perms.permits! :read
    # perms.permits! :write
  end

  # /garage

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
  has_many :administer_memberships, -> { administer }, as: :memberable, class_name: 'Membership'
  has_many :maintainer_memberships, -> { maintainer }, as: :memberable, class_name: 'Membership'
  has_many :member_memberships,     -> { member     }, as: :memberable, class_name: 'Membership'
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

  def self.from_omniauth auth
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.screen_name = auth.info.name
      user.user_name = uniq_user_name auth.info.nickname
      user.avatar_url = auth.info.image
      essential_token = user.access_tokens.new
      essential_token.name = '-'
      essential_token.token = AccessToken.generate_token
      essential_token.essential = true
    end
  end

end
