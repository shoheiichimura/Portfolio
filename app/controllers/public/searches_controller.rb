class Public::SearchesController < ApplicationController
  
  def index
    @customers = Customer.all
  end
  
  def search
     @results = @d.result
     render :index
  end
  
  private
  
  def search_customer
    @d = Customer.ransack(params[:q])
  end
end
