module DropdownOptionsHelper

  def options_for_clients
    current_clients.map do |client|
      [client.name, client.id]
    end
  end

  def options_for_active
    [
      [t('common.active'), true],
      [t('common.inactive'), false],
    ]
  end

  def options_for_hidden
    [
      [t('common.visible'), false],
      [t('common.hidden'), true],
    ]
  end

  def options_for_locale
    [
      [t('common.english'), 'en'],
      [t('common.polish'), 'pl'],
    ]
  end

end