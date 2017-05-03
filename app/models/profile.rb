class Profile < ApplicationRecord
  extend FriendlyId
  friendly_id :screen_name, use: [ :finders ]

  belongs_to :publisher, polymorphic: true
  validates :display_name, presence: true
  validates :screen_name, presence: true, unless: :archived?
  validates :archived, inclusion: {in: [true, false]}
  validates :screen_name, uniqueness: true
  validates :screen_name, length: { maximum: 64 }

  after_destroy :archive_profile

  attachment :avatar, destroy: false
  has_many :messages

  def archive!
    self.screen_name = nil
    self.archived = true
    self.save
  end

  def type
    publisher_type.downcase.to_sym
  end

  def user?
    type == :user
  end

  def bot?
    type == :bot
  end

  def archived?
    archived
  end

  def user
    publisher if publisher_type == 'User'
  end

  def bot
    publisher if publisher_type == 'Bot'
  end

end
