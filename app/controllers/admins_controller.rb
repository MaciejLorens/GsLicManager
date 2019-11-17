class AdminsController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :set_invitation, only: [:resend, :invitation_destroy]

  def index
    @admins = current_users.admins.visible
                .where(filter_query)
                .includes(:client)
                .order(sorting_query('last_name ASC'))
  end

  def invitations
    @invitations = current_invitations.admins.order(sorting_query)
  end

  def new
    @invitation = current_invitations.new
  end

  def edit
  end

  def resend
    @invitation.send_email

    redirect_to invitations_admins_url, notice: t('admin.admin_was_successfully_invited')
  end

  def invite
    @invitation = current_invitations.new(invitation_params)

    if @invitation.save
      redirect_to invitations_admins_path, notice: t('admin.admin_was_successfully_invited')
    else
      render :new
    end
  end

  def update
    if @admin.update(admin_params)
      redirect_to admins_path, notice: t('admin.admin_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @admin.hide!

    redirect_to admins_url, notice: t('admin.admin_was_successfully_deleted')
  end

  def invitation_destroy
    @invitation.destroy

    redirect_to invitations_admins_url, notice: t('user.invitation_was_successfully_deleted')
  end

  def batch_destroy
    @admins = current_users.where(id: params[:ids])
    @admins.each { |admin| admin.hide! }

    redirect_to admins_url, notice: t('admin.admins_was_successfully_deleted')
  end

  private

  def set_admin
    @admin = current_users.find(params[:id])
  end

  def set_invitation
    @invitation = current_invitations.find(params[:id])
  end

  def admin_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :locale,
      :password,
      :password_confirmation,
      :hidden,
      :hidden_at,
      :client_id,
    ).merge(role: 'admin')
  end

  def invitation_params
    params.require(:invitation).permit(
      :email,
      :locale,
      :client_id,
    ).merge(role: 'admin')
  end

end
