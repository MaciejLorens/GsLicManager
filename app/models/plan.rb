class Plan < ApplicationRecord

  include Hideable

  has_many :licenses

  belongs_to :app

end
