class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    #create a new instance of user with form data
    @user = User.new(user_params)
    #try to save it. 
    if @user.save
    #if saving succeeds, alert the user, send them to home
      flash[:notice] = "Your account was created successfully."
      redirect_to root_path
    #if it fails, let the user know all is not well, send them back to sign up page
    else
      flash[:alert] = "There was a problem creating your account."
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    #create a new instance of user with form data
    @user = User.find(params[:id])
    #try to save it. 
    if @user.update_attributes(user_params)
    #if saving succeeds, alert the user, send them to home
      flash[:notice] = "Your account was updated successfully."
      redirect_to user_path(@user)
    #if it fails, let the user know all is not well, send them back to sign up page
    else
      flash[:alert] = "There was a problem updating your account."
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User destroyed succcessfully."
    else
      flash[:alert] = "There was a problem destroying that user."
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname)
  end

end