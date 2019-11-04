class Api::V1::AppDataController < ApplicationController

	protect_from_forgery with: :null_session

 	def create
		#todo:
		#funkcja (user, token) DONE
		#sprawdzenie waznosci tokena po dacie utworzenia wazny 12 godzin DONE
    begin
		#Jesli user i token pasuja
  		if is_user_and_token_valid(params[:email], params[:token])
  			#pobiera id aplikacji z tab. user_apps
	  		user_app_ids = UserApp.where(user_id: @user.id, is_deleted: false, is_active: true).pluck(:app_id)

	  		#pobiera nazwy aplikacji z tab. app
	  		apps = App.where(id: user_app_ids, is_deleted: false)
	  		app_ids = App.where(id: user_app_ids, is_deleted: false).pluck(:id)
	  		#pobiera nazwy wersji aplikacji z tab. app_versions
	  		app_versions = AppVersion.where(app_id: app_ids)

        #pobiera typy licencji
        license_types = LicenseType.where(is_deleted: 0)

	  		#zwraca jsonem tablice w postaci 
	  		#"apps": app_id, app_name; "app_versions": app_id, ver_id, ver_name
	  		render json: {apps: apps, app_versions: app_versions, license_types: license_types}	
        create_log('INFO', 'App data downloaded by ' + params[:email].to_s)
  		else
  			render json: {message: 'Error: User or token not valid, cannot download app data'}
        create_log('ERROR','User or token not valid, cannot download app data')
  		end
    rescue Exception => e
      create_log('EXCEPTION', e.message)
    end
  end

  def is_user_and_token_valid(email_tmp, token_tmp)
	 @user = User.find_for_authentication(email: email_tmp)
    return false unless @user.present?
  	user_tokens = Token.where(user_id: @user.id, is_valid: true, created_at: [((Time.now-43200)..Time.now)]).pluck(:value)
  	return false unless user_tokens.include? token_tmp
 		return true
 	end

  def create_log(log_type, message)
    dir_path = Rails.root.to_s + '/Logs'
    Dir.mkdir(dir_path) unless File.exists?(dir_path)
    
    dir_path = dir_path + '/' + Date.today.to_s + '/'
    Dir.mkdir(dir_path) unless File.exists?(dir_path)
    
    file_path = dir_path + Date.today.to_s + '_lm.log'
    open(file_path, 'a'){ |f|
      f.puts Time.now.to_s + ' => ' + log_type + ': ' + message
    }
  end

  def get_history
    begin
      if is_user_and_token_valid(params[:email], params[:token])
        user_licenses = UserLicense.where(user_id: params[:user_id])
        render json: {user_licenses: user_licenses}
        create_log('INFO', 'License history downloaded by ' + params[:email].to_s)
      else
        render json: {message: 'Error: User or token not valid, cannot download licenses history'}
        create_log('ERROR','User or token not valid, cannot download licenses history')
      end
    rescue Exception => e
      create_log('EXCEPTION', e.message)
    end
  end

end
