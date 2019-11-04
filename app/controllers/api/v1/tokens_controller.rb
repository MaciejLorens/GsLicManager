class Api::V1::TokensController < ApplicationController

  protect_from_forgery with: :null_session

  def create
    begin
  	  # # username / password
      @user = User.find_for_authentication(email: params[:email])
      if @user.present?
        create_log('INFO', 'User ' + params[:email].to_s + ' found')
      else
        create_log('ERROR','User ' + params[:email].to_s + ' not found')
        return render json: {message: 'User not found'}
      end
      # return render json: {message: 'User not found'} unless @user.present?

      if is_blocked_or_active?(params[:email].to_s)
        create_log('INFO','User is active and not blocked')
      else
        create_log('ERROR','User is blocked or not active')
        return render json: {message: 'User is blocked or not active'}
      end

  	  # weryfikuje czy jest w DB user
  	  valid = @user.valid_password?(params[:password])
      if valid == true
        create_log('INFO','User ' + params[:email].to_s + ' is valid')
      else
        inc_block_counter(params[:email])
        create_log('ERROR','User ' + params[:email].to_s + ' is not valid')
        return render json: {user_valid: false}
      end
  	  # return render json: {user_valid: false} unless valid == true

  	  # tworze token i zapisu	je go do DB
  	  @new_token = @user.tokens.create(value: SecureRandom.hex(10), is_valid: true)
      if @new_token.id > 0
        create_log('INFO','Token ' + @new_token.value.to_s + ' generated for ' + params[:email].to_s)
      else
        create_log('ERROR','Token not found')
        return render json: {message: 'Token not found'}
      end
  	  # return render json: {message: 'Token not found' } unless @new_token.id > 0
  	
  	  # oznaczenie wszystkich wczesniejszych tokenow jako nieaktywne IsValid = false
  	  Token.where(user_id: @user.id, is_valid: true).where.not(id: @new_token.id).update_all(is_valid: false)
      
  	  # zwracam token do responsa
  	  render json: {token: @new_token.value, user_id: @user.id, blocked: @user.is_blocked, active: @user.is_active}
    rescue Exception => e
      create_log('EXCEPTION', e.message)
    end 	
  end

  #generowanie licencji 
  def generate
    # begin
      if is_user_and_token_valid(params[:email], params[:token])
        if check_if_register_key_exists(params[:register_key])
          app_name = App.where(id: params[:app_id]).pluck(:name_app)
          app_name = app_name[0]

          version_name = AppVersion.where(id: params[:ver_id]).pluck(:value)
          version_name = version_name[0]

          new_license = generate_new_app_code(app_name, version_name, 
                          params[:scales_amount], params[:register_key]) 

          render json: {new_app_code: new_license, reminder: 1}
          create_log('INFO', 'App code ' + new_license + ' once again generated for ' + params[:email].to_s) 
        else
          if can_generate?(params[:email])
            ul = UserLicense.new
            ul.app_id = params[:app_id]
            ul.app_version_id = params[:ver_id]
            ul.version_no = params[:ver_no]
            ul.scales_amount = params[:scales_amount]
            ul.license_type_id = params[:license_type_id]
            ul.old_app_code = params[:old_app_code]
            ul.register_key = params[:register_key]
            ul.description = params[:desc]
            ul.user_id = params[:user_id]

            app_name = App.where(id: ul.app_id).pluck(:name_app)
            app_name = app_name[0]

            version_name = AppVersion.where(id: ul.app_version_id).pluck(:value)
            version_name = version_name[0]

            ul.new_app_code = generate_new_app_code(app_name, version_name, 
                                                    params[:scales_amount], params[:register_key])

            if ul.save
              #wysylanie maili w zaleznosci od jezyka
              send_to = User.where(email: params[:email]).pluck(:send_to)
              send_to_splitted = send_to[0].split(';')
              company_name = User.where(email: params[:email]).pluck(:company_name)
              company_name = company_name[0]

              pref_lang = get_pref_lang(params[:email], params[:token])

              mail_our_address = Config.where(key: 'sender_email').pluck(:value_str1)
              mail_our_address = mail_our_address[0]

              if pref_lang == 'en'
                SummaryMailer.en_summary_created(mail_our_address, params[:email],
                                              company_name, app_name, version_name,
                                              ul).deliver
                for i in 0..(send_to_splitted.length - 1)
                  SummaryMailer.en_summary_created(send_to_splitted[i], params[:email],
                                                company_name, app_name, version_name,
                                                ul).deliver
                end
              elsif pref_lang == 'pl'
                SummaryMailer.pl_summary_created(mail_our_address, params[:email],
                                              company_name, app_name, version_name,
                                              ul).deliver
                for i in 0..(send_to_splitted.length - 1)
                  SummaryMailer.pl_summary_created(send_to_splitted[i], params[:email],
                                                company_name, app_name, version_name,
                                                ul).deliver
                end
              end
              render json: {new_app_code: ul.new_app_code, reminder: 0}
              #w BD zwiekszenie current_limit o 1
              inc_current_limit(params[:email])
              create_log('INFO', 'New app code ' + ul.new_app_code + ' generated for ' + params[:email].to_s) 
            else
              render json: {message: 'Error: Cannot save license to DB'}
              create_log('ERROR', 'Cannot save license to DB for ' + params[:email].to_s)
            end
          else
            render json: {message: 'Error: Limit exceeded'}
          end
        end
      else
        render json: {message: 'Error: User or token not valid, cannot generate'}
        create_log('ERROR','User or token not valid, cannot generate for ' + params[:email].to_s)
      end 
    # rescue Exception => e
    #   create_log('EXCEPTION', e.message)
    # end

  end

  def get_pref_lang(email, token)
    if is_user_and_token_valid(email, token)
        pref_lang = User.where(email: params[:email]).pluck(:pref_lang)
        create_log('INFO','Pref lang for ' + params[:email].to_s + ' is ' + pref_lang.to_s)
        return pref_lang[0]
    else
      create_log('ERROR','User or token not valid, cannot get pref lang for ' + params[:email].to_s)
      render json: {message: 'Error: User or token not valid, cannot get pref lang'}  
    end
  end

  def log_out
    begin
  		#Jesli user i token pasuja
  		if is_user_and_token_valid(params[:email], params[:token])
  			#Ustawia wszystkie tokeny na false
  			Token.where(user_id: @user.id, is_valid: true).update_all(is_valid: false)
        create_log('INFO','Log out successful by ' + params[:email].to_s)
  			render json: {message: 'Log out successful'}
  		else
        create_log('ERROR','User or token not valid, cannot log out by ' + params[:email].to_s)
  			render json: {message: 'Error: User or token not valid, cannot log out'}
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

  def generate_new_app_code(app_name, version_name, scales_amount, code_for_MD5)
    if scales_amount.to_i < 10
      scales_tmp = '0' + scales_amount
    else
      scales_tmp = scales_amount
    end

    result_MD5 = Digest::MD5.hexdigest(code_for_MD5 + '+X-ScaleFull+')
    result_MD5 = trim_code(result_MD5, 10)

    app_version_no = AppVersion.where(value: version_name).pluck(:version_no)
    app_version_no = app_version_no[0]

    result = app_version_no.to_s + '1' + scales_tmp + result_MD5;
    return result
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

  def can_generate?(email)
    is_active = User.where(email: email).pluck(:is_active)[0]
    is_blocked = User.where(email: email).pluck(:is_blocked)[0]

    if ((is_active == 1) and (is_blocked == 0))
      limit_change_date = User.where(email: email).pluck(:limit_change_date)
      limit_change_date = limit_change_date[0]

      if limit_change_date != Date.today
        u = User.where(email: email)
        u.update(current_limit_counter: 0, limit_change_date: Date.today)
        create_log('INFO', 'Current_limit = 0 for ' + email)
      end

      limit = User.where(email: email).pluck(:limit)
      limit = limit[0]
      cur_limit_counter = User.where(email: email).pluck(:current_limit_counter)
      cur_limit_counter = cur_limit_counter[0]

      if limit > cur_limit_counter
        return true
      else
        create_log('ERROR', 'Limit exceeded - current limit: ' + cur_limit_counter.to_s + '; limit: ' + limit.to_s)
        return false
      end
    else
      return false;
    end 
  end

  def inc_current_limit(email)
    u = User.where(email: email)
    cur_limit_counter = User.where(email: email).pluck(:current_limit_counter)
    new_current_limit_counter = cur_limit_counter[0] + 1
    u.update(current_limit_counter: new_current_limit_counter)
  end

  def is_blocked_or_active?(email)
    block_date = User.where(email: email).pluck(:block_date)
    block_date = block_date[0]

    if block_date.nil?
      block_date = DateTime.new(2018,1,1)
    end

    interval = Config.where(key: 'block_value').pluck(:value_str1)
    interval = interval[0].to_i

    is_blocked = User.where(email: email).pluck(:is_blocked)
    is_blocked = is_blocked[0]

    if block_date < (Time.current - interval*60) and is_blocked == 1
      u = User.where(email: email)
      u.update(is_blocked: 0, block_counter: 0)
    end

    is_active = User.where(email: email).pluck(:is_active)
    is_active = is_active[0]
    is_blocked = User.where(email: email).pluck(:is_blocked)
    is_blocked = is_blocked[0]

    if ((is_active == 1) and (is_blocked == 0))
      return true
    else
      return false
    end
  end

  def block_user(email)
    begin
      u = User.where(email: email)
      block_date = Time.current
      #musimy dac time.current zeby przeslalo w URC bo z BD pobiera czas jako UTC

      u.update(is_blocked: 1, block_date: block_date)

      create_log('INFO', 'User ' + email + ' blocked!')
      return render json: {blocked: 1}
    rescue Exception => e
      create_log('EXCEPTION', e.message)
    end
  end

  def check_if_register_key_exists(register_key)
    lic = UserLicense.where(register_key: register_key).pluck(:register_key)
    lic = lic[0]
    if lic.nil? 
      return false
    else
      return true
    end
  end

  def inc_block_counter(email)
    u = User.where(email: email)
    bc = User.where(email: email).pluck(:block_counter)[0]
    create_log("1.", " " + bc.to_s)
    bc += 1
    u.update(block_counter: bc)
    if bc >= 5
      block_user(email)
    end
  end
end
