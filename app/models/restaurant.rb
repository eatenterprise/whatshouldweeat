class Restaurant < ApplicationRecord
  belongs_to :round

  validates :name, presence: true
end
