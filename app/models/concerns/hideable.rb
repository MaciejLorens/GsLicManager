module Hideable

  extend ActiveSupport::Concern

  included do
    scope :visible, -> { where(hidden: false) }
    scope :hidden, -> { where(hidden: true) }
  end

  def hide!
    self.update(hidden: true, hidden_at: Time.current)
  end

  def unhide!
    self.update(hidden: false, hidden_at: nil)
  end

end
