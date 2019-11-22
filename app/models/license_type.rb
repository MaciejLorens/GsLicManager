class LicenseType < ApplicationRecord

  include Hideable

  has_many :licenses

end
