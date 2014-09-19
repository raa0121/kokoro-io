class Membership < ActiveRecord::Base
  belongs_to :room
  belongs_to :memberable, polymorphic: true
  belongs_to :user, class_name: 'User', foreign_key: :memberable_id
  belongs_to :bot, class_name: 'Bot', foreign_key: :memberable_id

  validates :authority, presence: true
  enum authority: {
    member: 10,
    maintainer: 20,
    admin: 100
  }

  scope :administer, ->{ where authority: self.authorities[:admin] }
  scope :maintainer, ->{ where authority: self.authorities[:maintainer] }
  scope :member,     ->{ where authority: self.authorities[:member] }

  before_validation :bind_default_values

  private
  def bind_default_values
    self.authority ||= :member
  end
end
