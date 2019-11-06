class App < ApplicationRecord

  include Hideable

  has_many :versions
  has_many :types

end
