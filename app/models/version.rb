class Version < ApplicationRecord

  include Hideable

  has_many :licenses
  has_many :users, through: :license

  belongs_to :app

  def generate_new_app_code(scales_amount, code_for_MD5)
    scales_tmp = scales_amount.to_i < 10 ? '0' + scales_amount : scales_amount

    result_md5 = Digest::MD5.hexdigest(code_for_MD5 + '+X-ScaleFull+')
    result_md5 = trim_code(result_md5, 10)

    number + '1' + scales_tmp + result_md5
  end

  def trim_code(code_to_trim, count)

    code_length = (code_to_trim.length - 1)
    if code_length <= 0
      return ''
    end
    result = ''
    for i in 0..(code_length)
      if ((i % 2) != 0)
        result = result + code_to_trim[i]
      else
        result = result + code_to_trim[code_length - i - 1]
      end
    end
    final_result = ''
    for j in 0..(count - 1)
      if j <= code_length - 1
        final_result = final_result + result[j]
      end
    end
    return final_result
  end

end
