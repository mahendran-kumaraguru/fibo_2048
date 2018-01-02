class Game < ActiveRecord::Base
  belongs_to :user
  serialize :data
  validates_inclusion_of :grid, :in => 3..8
end
