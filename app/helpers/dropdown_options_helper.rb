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

  def options_for_clients
    current_clients.visible.order('name ASC').map do |client|
      [client.name, client.id]
    end
  end

  def options_for_apps
    current_apps.visible.order('name ASC').map do |app|
      [app.name, app.id]
    end
  end

  def options_for_versions
    current_versions.visible.order('number DESC').map do |version|
      [version.number, version.id, 'data-app_id' => version.app.id]
    end
  end

  def options_for_plans
    current_plans.visible.order('val_pl ASC').map do |plan|
      [plan.send("val_#{I18n.locale}"), plan.id, 'data-app_id' => plan.app.id]
    end
  end

  def options_for_license_types
    current_license_types.visible.order('val_pl ASC').map do |type|
      [type.send("val_#{I18n.locale}"), type.id]
    end
  end

  def options_for_license_statuses
    current_license_statuses.visible.order('val_pl ASC').map do |status|
      [status.send("val_#{I18n.locale}"), status.id]
    end
  end

  def options_for_users
    current_users.visible.order('last_name ASC').map do |user|
      [user.full_name, user.id]
    end
  end

  def options_for_locale
    t('common.locales').map do |locale, translation|
      [translation, locale]
    end
  end

end
