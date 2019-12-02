class UsersController < ApplicationController



  def show
  	@user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new

  end

  def index
  	@user_all = User.all
    @book = Book.new
    @user = current_user
  end

  def edit
  	 	@user = User.find(params[:id])
      if current_user != @user
        redirect_to user_path(current_user)
      end
  end

  def  update
    @user = User.find(params[:id])
    @user.update(user_params)
      if @user.save
   flash[:message] = "book has been added successfully"
    redirect_to user_path(@user.id)
  else
    flash[:message] = ' error ! can not be blank '
         @user = current_user
      render:edit

  end
  end

   private
     def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
     end

    def authenticate_user
    user = User.find(params[:id])
     if current_user.id != (user.id)
      redirect_to books_path
     end
    end
end
