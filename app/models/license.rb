class License < ApplicationRecord

  include Hideable

  belongs_to :user
  belongs_to :version
  belongs_to :app
  belongs_to :type

end
