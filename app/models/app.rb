class App < ApplicationRecord

  include Hideable

  has_many :versions

end
