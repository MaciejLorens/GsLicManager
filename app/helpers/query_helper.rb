module QueryHelper

  def filter_query(default_field = nil)
    query = "id IS NOT NULL"

    if params[:f_email].present?
      query += " AND email LIKE '%#{params[:f_email].gsub('*', '')}%'"
    end

    if params[:f_first_name].present?
      query += " AND first_name LIKE '%#{params[:f_first_name].gsub('*', '')}%'"
    end

    if params[:f_last_name].present?
      query += " AND last_name LIKE '%#{params[:f_last_name].gsub('*', '')}%'"
    end

    if params[:f_val_pl].present?
      query += " AND val_pl LIKE '%#{params[:f_val_pl].gsub('*', '')}%'"
    end

    if params[:f_val_en].present?
      query += " AND val_en LIKE '%#{params[:f_val_en].gsub('*', '')}%'"
    end

    if params[:f_name].present?
      query += " AND name LIKE '%#{params[:f_name].gsub('*', '')}%'"
    end

    if params[:f_value].present?
      query += " AND value LIKE '%#{params[:f_value].gsub('*', '')}%'"
    end

    if params[:f_number].present?
      query += " AND number LIKE '%#{params[:f_number].gsub('*', '')}%'"
    end

    if params[:f_end_client_name].present?
      query += " AND end_client_name LIKE '%#{params[:f_end_client_name].gsub('*', '')}%'"
    end

    if params[:f_end_client_address].present?
      query += " AND end_client_address LIKE '%#{params[:f_end_client_address].gsub('*', '')}%'"
    end

    if params[:f_description].present?
      query += " AND description LIKE '%#{params[:f_description].gsub('*', '')}%'"
    end

    if params[:f_order_number].present?
      query += " AND order_number LIKE '%#{params[:f_order_number].gsub('*', '')}%'"
    end

    if params[:f_registration_key].present?
      query += " AND registration_key LIKE '%#{params[:f_registration_key].gsub('*', '')}%'"
    end

    if params[:f_unlock_code].present?
      query += " AND unlock_code LIKE '%#{params[:f_unlock_code].gsub('*', '')}%'"
    end

    if params[:f_locale].present?
      query += " AND locale LIKE '#{params[:f_locale]}'"
    end

    if params[:f_license_plan_id].present?
      query += " AND license_plan_id = #{params[:f_license_plan_id]}"
    end

    if params[:f_license_status_id].present?
      query += " AND license_status_id = #{params[:f_license_status_id]}"
    end

    if params[:f_license_type_id].present?
      query += " AND license_type_id = #{params[:f_license_type_id]}"
    end

    if params[:f_version_id].present?
      query += " AND version_id = #{params[:f_version_id]}"
    end

    if params[:f_user_id].present?
      query += " AND user_id = #{params[:f_user_id]}"
    end

    if params[:f_client_id].present?
      query += " AND client_id = #{params[:f_client_id]}"
    end

    if params[:f_app_id].present?
      query += " AND app_id = #{params[:f_app_id]}"
    end

    if params[:f_hidden].present?
      query += " AND hidden = #{params[:f_hidden]}"
    end

    query
  end

  def sorting_query(default = nil)
    query = default || "created_at DESC"

    if params[:s_field].present? && params[:s_order].present?
      query = "#{params[:s_field]} #{params[:s_order]}"
    end

    query
  end

end
