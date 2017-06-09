class User < ApplicationRecord
  validates :name, presence: true

  belongs_to :round
end
