module NavbarHelper

  def sort_class(field)
    params[:s_field] == field ? params[:s_order] : ''
  end

  def nav_link(link_text, link_path)
    classes = 'link'
    classes += ' active' if current_page?(link_path)

    link_to link_text, link_path, class: classes
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

  def register_action?
    controller.action_name == 'register'
  end

  def duplicate_action?
    controller.action_name == 'duplicate'
  end

  def history_action?
    controller.action_name == 'history'
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

  def register_active?
    controller.action_name == 'register' ? 'active' : ''
  end

  def duplicate_active?
    controller.action_name == 'duplicate' ? 'active' : ''
  end

  def history_active?
    controller.action_name == 'history' ? 'active' : ''
  end

end
