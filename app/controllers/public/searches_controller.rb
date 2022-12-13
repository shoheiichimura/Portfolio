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
    @p = Customer.ransack(params[:q])  # 検索オブジェクトを生成
    @results = @p.result
  end
end
