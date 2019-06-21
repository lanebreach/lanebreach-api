class Api::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show
    else
      render_errors(@user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :show
    else
      render_errors(@user)
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(User.attribute_names - [:id, :created_at, :updated_at])
  end
end
