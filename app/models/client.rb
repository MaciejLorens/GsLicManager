class Client < ApplicationRecord

  include Hideable

  has_many :users

end