class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def add_coin
    amount = params[:amount]
    @user = User.find(params[:user_id])
    @user.add_coin(Float(amount))
    redirect_to @user, notice: 'Got coin.'
  end
  
  def destroy
		@user = User.find(params[:id])
		@user.destroy
	end

	def index
		@users = User.all
		@user = current_user
	end
  
  def show
		@user = User.find(params[:id])
    @sales = @user.sales

		if current_user.id == @user.id
			render action: :show
		elsif current_user.following?(@user)
			render action: :show 
		else
			render file: 'public/denied', formats: [:html]
		end
	end
  
  private 
  def user_params
    params.require(:user).permit(:email, :coin)
   end
end
