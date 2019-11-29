class License < ApplicationRecord

  include Hideable

  belongs_to :client
  belongs_to :user, optional: true

  belongs_to :plan
  belongs_to :version
  belongs_to :app

  belongs_to :license_status
  belongs_to :license_type

  SALT = '+X-ScaleFull+'.freeze

  def generate_unlock_code(user, amount)
    result_md5 = Digest::MD5.hexdigest(registration_key + SALT)
    unlock_code = version.number + '1' + scales(amount) + trim(result_md5, 10)
    update(unlock_code: unlock_code, user_id: user.id, license_status_id: LicenseStatus.find_by(val_en: 'Registered').id)
  end

  private

  def scales(amount)
    amount.to_i < 10 ? "0#{amount}" : amount.to_s
  end

  def trim(code, trim)
    return '' if code.blank?
    (0..trim - 1).map { |i| (i % 2).zero? ? code[code.length - i - 2] : code[i] }.join('')
  end

end
