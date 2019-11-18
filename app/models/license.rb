class License < ApplicationRecord

  include Hideable

  belongs_to :user
  belongs_to :version
  belongs_to :app
  belongs_to :type
  belongs_to :client

  STATUSES = %w(active inactive).freeze
  SALT = '+X-ScaleFull+'.freeze

  before_save :set_app_id

  def generate_unlock_code(amount)
    result_md5 = Digest::MD5.hexdigest(registration_key + SALT)
    unlock_code = version.number + '1' + scales(amount) + trim(result_md5, 10)
    update(unlock_code: unlock_code)
  end

  private

  def set_app_id
    self.app_id = version.app_id
  end

  def scales(amount)
    amount.to_i < 10 ? "0#{amount}" : amount.to_s
  end

  def trim(code, trim)
    return '' if code.blank?
    (0..trim - 1).map { |i| (i % 2).zero? ? code[code.length - i - 2] : code[i] }.join('')
  end

end
