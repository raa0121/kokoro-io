class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
