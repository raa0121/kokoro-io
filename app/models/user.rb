
class User < ApplicationRecord

  extend FriendlyId
  friendly_id :screen_name

  validates :screen_name, uniqueness: true
  # Github username may only contain alphanumeric
  # characters or dashes and cannot begin with a dash
  validates :screen_name, friendly_id: true
  validates :screen_name, length: { in: 1..39 }
  validates :uid, uniqueness: true
  validates :provider, :uid, :screen_name, :user_name, :avatar_url, presence: true

  has_many :access_tokens
  has_many :messages, as: :publisher
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships
  has_many :bots

  # Has scoped rooms by each authority
  has_many :administrator_memberships, -> { administrator }, as: :memberable, class_name: 'Membership'
  has_many :maintainer_memberships, -> { maintainer }, as: :memberable, class_name: 'Membership'
  has_many :member_memberships,     -> { member     }, as: :memberable, class_name: 'Membership'
  has_many :invited_memberships,    -> { invited    }, as: :memberable, class_name: 'Membership'
  has_many :chattable_memberships,  -> { administrator || maintainer || member }, as: :memberable, class_name: 'Membership'
  has_many :administrator_rooms, source: :room, through: :administrator_memberships
  has_many :maintainer_rooms, source: :room, through: :maintainer_memberships
  has_many :member_rooms,     source: :room, through: :member_memberships
  has_many :invited_rooms,    source: :room, through: :invited_memberships
  has_many :chattable_rooms,  source: :room, through: :chattable_memberships

  delegate :private_rooms, to: :rooms
  delegate :public_rooms, to: :rooms

  def primary_access_token
    access_tokens.primary.first
  end

  def avatar_thumbnail_url size = 64
    "#{avatar_url}&s=#{size}"
  end

  def self.uniq_screen_name github_screen_name
    github_screen_name.downcase!
    return github_screen_name if User.where(screen_name: github_screen_name).size == 0
    loop.with_index(2) do |_, i|
      screen_name = "#{github_screen_name}#{i}"
      return screen_name if User.where(screen_name: screen_name).size == 0
    end
  end

  def self.from_omniauth auth
    User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.screen_name = auth.info.name
      user.user_name = uniq_screen_name auth.info.nickname
      user.avatar_url = auth.info.image
      essential_token = user.access_tokens.new
      essential_token.name = '-'
      essential_token.token = AccessToken.generate_token
      essential_token.essential = true
    end
  end

end
