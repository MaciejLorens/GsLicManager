module NavbarHelper

  def sort_class(field)
    params[:s_field] == field ? params[:s_order] : ''
  end


  def index_action?
    controller.action_name == 'index'
  end

  def new_action?
    controller.action_name == 'new'
  end

  def show_action?
    controller.action_name == 'show'
  end

  def edit_action?
    controller.action_name == 'edit'
  end


  def index_active?
    controller.action_name == 'index' ? 'active' : ''
  end

  def invitations_active?
    controller.action_name == 'invitations' ? 'active' : ''
  end

  def new_active?
    controller.action_name == 'new' ? 'active' : ''
  end

  def show_active?
    controller.action_name == 'show' ? 'active' : ''
  end

  def edit_active?
    controller.action_name == 'edit' ? 'active' : ''
  end

end
