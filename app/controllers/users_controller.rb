class UsersController < ApplicationController
  def index
    @users = User.all
    # @user = current_user

  end
  def update
    @user = current_user    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to root_path, notice: "user was successfully updated." }
      # else
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    # redirect_to root_path
  end

  def new
    @user = User.new
  end


  def show

    # if user_signed_in?
    #   redirect_to root_path
    # else
    #   redirect_to new_user_session_path
    # end
  end


  def user_params
    params.require(:user).permit(:resume)
  end
end
