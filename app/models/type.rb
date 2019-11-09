class Type < ApplicationRecord

  include Hideable

  has_many :licenses

end
