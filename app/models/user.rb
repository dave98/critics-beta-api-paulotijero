class User < ApplicationRecord
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :birth_date, comparison: { less_than: 16.years.ago,
                                       message: "should be older than 16 years ago" },
                         allow_blank: true

  # Association
  has_many :critics, dependent: :destroy
end
