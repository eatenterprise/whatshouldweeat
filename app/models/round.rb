require 'securerandom'

class Round < ApplicationRecord

  has_many :restaurants
  has_many :users
  validates :key, presence: true, uniqueness: true

  def self.makeKey
    # (0...4).map { ('a'..'z').to_a[rand(26)] }.join
    SecureRandom.urlsafe_base64(3)
  end

  def vote_url
    "whatshouldweeat.herokuapp.com/#{self.key}"
  end
end

