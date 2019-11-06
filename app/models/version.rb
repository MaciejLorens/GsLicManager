class Version < ApplicationRecord

  include Hideable

  has_many :licenses
  has_many :users, through: :license

  belongs_to :app

end
