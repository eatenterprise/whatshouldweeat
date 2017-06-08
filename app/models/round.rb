class Round < ApplicationRecord
  has_many :restaurants

  validates :key, presence: true, uniqueness: true
end
