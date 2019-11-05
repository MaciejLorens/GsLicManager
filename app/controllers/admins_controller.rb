class AdminsController < ApplicationController

  before_action :authorize_super_admin

  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :set_invitation, only: [:resend, :invitation_destroy]

  def index
    @admins = User.admins.visible
                .where(filter_query)
                .order(sorting_query('last_name ASC'))
  end

  def invitations
    @invitations = Invitation.all.admins
                      .order(sorting_query)
  end

  def new
    @invitation = Invitation.new
  end

  def edit
  end

  def resend
    @invitation.send_email

    redirect_to invitations_admins_url, notice: t('admin.admin_was_successfully_invited')
  end

  def invite
    @invitation = Invitation.new(invitation_params)

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
    @admins = User.admins.where(id: params[:ids])
    @admins.each { |admin| admin.hide! }

    redirect_to admins_url, notice: t('admin.admins_was_successfully_deleted')
  end

  private

  def set_admin
    @admin = User.admins.find(params[:id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def admin_params
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation
    ).merge(role: 'admin')
  end

  def invitation_params
    params.require(:invitation).permit(
      :email
    ).merge(role: 'admin')
  end

end
