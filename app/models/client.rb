class Client < ApplicationRecord

  include Hideable

  has_many :users
  has_many :licenses

end
