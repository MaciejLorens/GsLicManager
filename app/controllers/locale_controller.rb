class LocaleController < ApplicationController

  def set
    current_user.update(locale: params[:locale])
    redirect_to root_path, notice: t('locale.locale_was_successfully_updated')
  end

end
