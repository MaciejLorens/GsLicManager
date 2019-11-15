require 'test_helper'

class AppTest < ActiveSupport::TestCase
  test 'generates proper unlock key' do
    version = Version.first

    result = version.generate_new_app_code('10', 'asdf')
    assert_equal result, 'special-number-123110525f9c57ed'

    result = version.generate_new_app_code('10', '5g35g')
    assert_equal result, 'special-number-123110ad72aca553'

    result = version.generate_new_app_code('5', 'q43rq23')
    assert_equal result, 'special-number-1231058308313d53'

    result = version.generate_new_app_code('1', 'muyuy')
    assert_equal result, 'special-number-123101695c652bf7'

    result = version.generate_new_app_code('3', '56h56j')
    assert_equal result, 'special-number-123103bc1548ae2b'
  end
end
