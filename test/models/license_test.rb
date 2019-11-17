require 'test_helper'

class AppTest < ActiveSupport::TestCase
  setup do
    @license = License.first
  end

  test 'generates proper unlock key #1' do
    @license.update(registration_key: 'hw45h4h4g45fgt')
    @license.generate_unlock_code(10)
    assert_equal @license.unlock_key, 'special-number-123110217df4dee9'
  end

  test 'generates proper unlock key #2' do
    @license.update(registration_key: '4h4542y45y35t34t5e7j67k84i6734t3434trge45h56j2q')
    @license.generate_unlock_code('10')
    assert_equal @license.unlock_key, 'special-number-12311008d20e0502'
  end

  test 'generates proper unlock key #3' do
    @license.update(registration_key: 'q43rq23')
    @license.generate_unlock_code(5)
    assert_equal @license.unlock_key, 'special-number-1231058308313d53'
  end

  test 'generates proper unlock key #4' do
    @license.update(registration_key: 'oooooooo')
    @license.generate_unlock_code('1')
    assert_equal @license.unlock_key, 'special-number-123101b7353c6f74'
  end

  test 'generates proper unlock key #5' do
    @license.update(registration_key: 'nil_blank_empty')
    @license.generate_unlock_code('hw4h45h4w')
    assert_equal @license.unlock_key, 'special-number-12310hw4h45h4w5ec386a890'
  end

  test 'generates proper unlock key #6' do
    @license.update(registration_key: '1')
    @license.generate_unlock_code(8)
    assert_equal @license.unlock_key, 'special-number-123108b341d0f5aa'
  end

  test 'generates proper unlock key #7' do
    @license.update(registration_key: '')
    @license.generate_unlock_code(21)
    assert_equal @license.unlock_key, 'special-number-1231212aeb1bff22'
  end

  test 'generates proper unlock key #8' do
    @license.update(registration_key: 'h425hw246jn2w6j6')
    @license.generate_unlock_code('')
    assert_equal @license.unlock_key, 'special-number-123102448e0caaf'
  end

  test 'generates proper unlock key #9' do
    @license.update(registration_key: '')
    @license.generate_unlock_code('')
    assert_equal @license.unlock_key, 'special-number-123102aeb1bff22'
  end

  test 'generates proper unlock key #10' do
    @license.update(registration_key: '4')
    @license.generate_unlock_code(nil)
    assert_equal @license.unlock_key, 'special-number-12310f065913f65'
  end
end
