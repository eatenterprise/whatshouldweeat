# require 'securerandom'

class Round < ApplicationRecord

  has_many :restaurants, dependent: :destroy
  has_many :users, dependent: :destroy
  validates :key, presence: true, uniqueness: true

  def self.makeKey
    (0...5).map { ('A'..'Z').to_a[rand(26)] }.join
    # SecureRandom.urlsafe_base64(3)
  end

  def vote_url
    "whatshouldweeat.herokuapp.com/#{self.key}"
  end
end

