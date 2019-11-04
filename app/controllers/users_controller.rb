class UsersController < ApplicationController

  before_action :authorize_admin

  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_invitation, only: [:resend, :invitation_destroy]

  def index
    # @users = current_users.users
    #            .where(filter_query)
    #            .includes(:client, :company)
    #            .order(sorting_query('last_name ASC'))

    @users = User.all
  end

  def invitations
    @invitations = current_invitations.users
                     .includes(:company)
                     .order(created_at: :desc)
  end

  def new
    @invitation = current_invitations.new
  end

  def edit
  end

  def resend
    @invitation.send_email

    redirect_to invitations_users_url, notice: t('user.user_was_successfully_invited')
  end

  def invite
    @invitation = current_invitations.create(invitation_params)

    if @invitation.save
      redirect_to invitations_users_path, notice: t('user.user_was_successfully_invited')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: t('user.user_was_successfully_edited')
    else
      render :edit
    end
  end

  def destroy
    @user.hide!

    redirect_to users_url, notice: t('user.user_was_successfully_deleted')
  end

  def invitation_destroy
    @invitation.destroy

    redirect_to invitations_users_url, notice: t('user.invitation_was_successfully_deleted')
  end

  def batch_destroy
    @users = current_users.where(id: params[:ids])
    @users.each { |user| user.hide! }

    redirect_to users_url, notice: t('user.users_was_successfully_deleted')
  end

  private

  def set_user
    @user = current_users.find(params[:id])
  end

  def set_invitation
    @invitation = current_invitations.find(params[:id])
  end

  def user_params
    # === TODO:Maciej: merge company_id only if super_admin?
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :hidden,
      :hidden_at,
      :client_id,
      :company_id
    ).merge(role: 'user')
  end

  def invitation_params
    # === TODO:Maciej: merge company_id only if super_admin?
    params.require(:invitation).permit(
      :email,
      :client_id,
      :company_id
    ).merge(role: 'user')
  end

end
