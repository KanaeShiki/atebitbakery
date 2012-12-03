class FinderController < ApplicationController
    def index
    @products = Product.order(:name)
    
    if session[:count].nil?
      session[:count] = 1
    else 
      session[:count] += 1
    end
    
    @count = session[:count]
  end
  
  def forget_me_bro
    session[:count] = nil
    redirect_to root_path
  end
  
  def search
  end # Loads up the search.html.erb view file.
  
  def search_results
    @keyword = params[:keyword]
    
    @products = Product.where("name LIKE ?", "%#{@keyword}%")
  end
end
