class App < ApplicationRecord

  include Hideable

  has_many :plans
  has_many :versions
  has_many :licenses

end
