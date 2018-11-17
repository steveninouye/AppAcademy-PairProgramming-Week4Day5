class UsersController < ApplicationController
  # before_action :current_user
  
  def index
  end

  def new
    return redirect_to users_index_url if current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to users_show_url(user)
    else
      flash[:errors] = 'User not created'
      render :new
    end
  end

  def show
  end

  def destroy
    if current_user
      current_user.destroy
      redirect_to users_index_url  
    else
      render json: "Invalid request", status: 401 
    end
  end

  def update
    if current_user
      current_user.update(user_params)
      redirect_to users_show_url(current_user)
    else
      render json: "Invalid request", status: 401 
    end
  end

  def edit
  end
  
  def user_params
    params.require(:user).permit(:username,:password)
  end
end
