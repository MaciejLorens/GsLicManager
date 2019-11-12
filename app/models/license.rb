class License < ApplicationRecord

  include Hideable

  belongs_to :user
  belongs_to :version
  belongs_to :type
  belongs_to :client

  STATUSES = %w(active inactive).freeze

end
