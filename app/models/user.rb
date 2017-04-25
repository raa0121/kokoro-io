class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile, as: :publisher
  accepts_nested_attributes_for :profile
  delegate :screen_name, to: :profile, prefix: false, allow_nil: true
  delegate :display_name, to: :profile, prefix: false, allow_nil: true
  delegate :messages, to: :profile, prefix: false, allow_nil: true
  delegate :avatar, to: :profile, prefix: false, allow_nil: true
  has_many :access_tokens
  has_many :memberships, as: :memberable
  has_many :rooms, through: :memberships
  has_many :bots

  # Has scoped rooms by each authority
  has_many :administrator_memberships, -> {
    where(authority: Membership.authorities[:administrator])
  }, as: :memberable, class_name: 'Membership'

  has_many :maintainer_memberships, -> {
    where(authority: Membership.authorities[:maintainer])
  }, as: :memberable, class_name: 'Membership'

  has_many :member_memberships, -> {
    where(authority: Membership.authorities[:member])
  }, as: :memberable, class_name: 'Membership'

  has_many :invited_memberships, -> {
    where(authority: Membership.authorities[:invited])
  }, as: :memberable, class_name: 'Membership'

  has_many :chattable_memberships, -> {
    where(authority: Membership.authorities.select {|k, v| ["administrator", "maintainer", "member"].include? k}.values)
  }, as: :memberable, class_name: 'Membership'

  has_many :administrator_rooms, source: :room, through: :administrator_memberships
  has_many :maintainer_rooms, source: :room, through: :maintainer_memberships
  has_many :member_rooms,     source: :room, through: :member_memberships
  has_many :invited_rooms,    source: :room, through: :invited_memberships
  has_many :chattable_rooms,  source: :room, through: :chattable_memberships

  delegate :private_rooms, to: :rooms
  delegate :public_rooms, to: :rooms

  def primary_access_token
    if access_tokens.primary.first
      access_tokens.primary.first
    else
      access_tokens.create(
        name: 'Primary Token',
        token: AccessToken.generate_token,
        essential: true
      )
    end
  end
end
