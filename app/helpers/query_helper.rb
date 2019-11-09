module QueryHelper

  def filter_query(default_field = nil)
    query = "id IS NOT NULL"

    # if params[:f_created_at_from].present? || default_field == :created_at
    #   value = params[:f_created_at_from].try(:to_date) || 1.month.ago
    #   query += " AND created_at >= '#{value.beginning_of_day}'"
    # end
    #
    # if params[:f_created_at_to].present? || default_field == :created_at
    #   value = params[:f_created_at_to].try(:to_date) || Date.today
    #   query += " AND created_at <= '#{value.end_of_day}'"
    # end

    if params[:f_email].present?
      query += " AND email LIKE '%#{params[:f_email].gsub('*', '')}%'"
    end

    if params[:f_first_name].present?
      query += " AND first_name LIKE '%#{params[:f_first_name].gsub('*', '')}%'"
    end

    if params[:f_last_name].present?
      query += " AND last_name LIKE '%#{params[:f_last_name].gsub('*', '')}%'"
    end

    # if params[:f_address].present?
    #   query += " AND address LIKE '%#{params[:f_address].gsub('*', '')}%'"
    # end
    #
    # if params[:f_postcode].present?
    #   query += " AND postcode LIKE '%#{params[:f_postcode].gsub('*', '')}%'"
    # end
    #
    # if params[:f_city].present?
    #   query += " AND city LIKE '%#{params[:f_city].gsub('*', '')}%'"
    # end
    #
    # if params[:f_country].present?
    #   query += " AND country LIKE '%#{params[:f_country].gsub('*', '')}%'"
    # end
    #
    # if params[:f_pin].present?
    #   query += " AND pin LIKE '%#{params[:f_pin].gsub('*', '')}%'"
    # end

    if params[:f_key].present?
      query += " AND key LIKE '%#{params[:f_key].gsub('*', '')}%'"
    end

    if params[:f_en].present?
      query += " AND en LIKE '%#{params[:f_en].gsub('*', '')}%'"
    end

    if params[:f_pl].present?
      query += " AND pl LIKE '%#{params[:f_pl].gsub('*', '')}%'"
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

    if params[:f_app_id].present?
      query += " AND app_id = #{params[:f_app_id]}"
    end

    # if params[:f_car_number].present?
    #   query += " AND car_number LIKE '%#{params[:f_car_number].gsub('*', '')}%'"
    # end
    #
    # if params[:f_trailer_number].present?
    #   query += " AND trailer_number LIKE '%#{params[:f_trailer_number].gsub('*', '')}%'"
    # end
    #
    # if params[:f_active].present?
    #   query += " AND active = #{params[:f_active]}"
    # end

    if params[:f_hidden].present?
      query += " AND hidden = #{params[:f_hidden]}"
    end

    # if params[:f_driver_id].present?
    #   query += " AND driver_id = #{params[:f_driver_id]}"
    # end
    #
    # if params[:f_client_id].present?
    #   query += " AND client_id = #{params[:f_client_id]}"
    # end
    #
    # if params[:f_product_id].present?
    #   query += " AND product_id = #{params[:f_product_id]}"
    # end
    #
    # if params[:f_user_id].present?
    #   query += " AND user_id = #{params[:f_user_id]}"
    # end

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
