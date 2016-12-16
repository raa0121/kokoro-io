class Membership < ApplicationRecord
  belongs_to :room
  belongs_to :memberable, polymorphic: true
  belongs_to :user, class_name: 'User', foreign_key: :memberable_id
  belongs_to :bot, class_name: 'Bot', foreign_key: :memberable_id

  validates :authority, presence: true
  enum authority: {
    administer: 100,
    maintainer: 20,
    member: 10,
    invited: 1000
  }

  # scope :administer, ->{ where authority: self.authorities[:administer] }
  # scope :maintainer, ->{ where authority: self.authorities[:maintainer] }
  # scope :member,     ->{ where authority: self.authorities[:member] }
  # scope :invited,    ->{ where authority: self.authorities[:invited] }

  before_validation :bind_default_values

  private
  def bind_default_values
    self.authority ||= :member
  end
end
