class UsersController < ApplicationController
  layout "application_control"
  before_action :authenticate_user!
  load_resource
  authorize_resource :except => [:control]

  def index
    @users = User.all.reject{|u| u.email == Setting.admins.email }
  end

  def show
    @user = User.find(params[:id])
    @roles = @user.roles.all
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all.reject{|role| role.name == Setting.roles.super_admin }
  end

  def update
    @user = User.find(params[:id])
    @user.set_roles(params[:roles])
    if @user.save
      redirect_to @user
    else
      render :edit
    end
  end

  def control
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :action => :index
  end
    

  private

    def user_params
      params.require(:user).permit(:email)
    end
end
