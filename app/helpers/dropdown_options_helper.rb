module DropdownOptionsHelper

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

  def options_for_status
    [
      [t('common.statuses.active'), 'active'],
      [t('common.statuses.inactive'), 'inactive'],
    ]
  end

  def options_for_users
    current_users.visible.order('last_name ASC').map do |user|
      [user.full_name, user.id]
    end
  end

  def options_for_clients
    current_clients.visible.order('name ASC').map do |client|
      [client.name, client.id]
    end
  end

  def options_for_types
    current_types.visible.order('value ASC').map do |type|
      [type.send(I18n.locale), type.id]
    end
  end

  def options_for_versions
    current_versions.visible.order('number ASC').map do |version|
      [version.number, version.id]
    end
  end

  def options_for_apps
    current_apps.visible.order('name ASC').map do |app|
      [app.name, app.id]
    end
  end

  def options_for_locale
    t('common.locales').map do |locale, translation|
      [translation, locale]
    end
  end

end
