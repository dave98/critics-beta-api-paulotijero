class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates :birth_date, comparison: { less_than: 16.years.ago,
                                       message: "should be older than 16 years ago" },
                         allow_blank: true

  # Association
  has_many :critics, dependent: :destroy
end
