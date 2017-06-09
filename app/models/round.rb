class Round < ApplicationRecord
  before_create :set_key

  has_many :restaurants

  validates :key, presence: true, uniqueness: true



  def set_key
    # if we want cap letters
    # self.key = Array.new(8){rand(36).to_s(36)}.map {|y| y =~ /[^o]/ ? y.upcase : y }.join
    self.key = Array.new(8){rand(36).to_s(36)}.join
  end
end
