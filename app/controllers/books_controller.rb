class BooksController < ApplicationController
     before_action :authenticate_user!, { except: [:top, :about] }
  def top
  end

  def about
  end

  def index
  	 @book = Book.new
  	 @book_all = Book.all
     @user = current_user
   end

  def show
     @book_new = Book.new
     @book = Book.find(params[:id])
   end

  def create
 	  @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
   flash[:message] = "book has been added successfully"
    redirect_to book_path(@book.id)
  else
    flash[:message] = ' error ! can not be blank '
    @book_all = Book.all
    @user = current_user
      render:index
  end
   end

  def edit
  	@book = Book.find(params[:id])
     if current_user != @book.user
      redirect_to books_path
  end
   end

  def update
  book = Book.find(params[:id])
    if book.update(book_params)
    redirect_to book_path
    flash[:message] = 'Update has successfully'
    else
      flash[:message] = ' error ! can not be blank '
      @book = Book.find(params[:id])
    render:edit
  end
end

 def destroy
 	book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
 end

  private
    def book_params
      params.require(:book).permit(:title, :body)
  end
end
