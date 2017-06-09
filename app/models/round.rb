class Round < ApplicationRecord
  before_create :set_key

  has_many :restaurants
  has_many :users
  validates :key, presence: true, uniqueness: true

  def self.makeKey
    (0...4).map { ('a'..'z').to_a[rand(26)] }.join
  end

end

