class LicensePlan < ApplicationRecord

  include Hideable

  has_many :licenses

end
