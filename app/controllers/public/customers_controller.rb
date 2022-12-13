class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:alert] = "更新完了しました！"
      redirect_to customer_path(@customer)
    else
      render "edit"
    end
  end

  def confirm
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def search
     @results = @d.result
     render :index
  end

  private
  def customer_params
  params.require(:customer).permit(:name,:introduction, :email,:sex,:profile_image,:active_area,:objective,:frequency,:heart,:traning_style)
  end

  def search_customer
    @d = Customer.ransack(params[:q])
  end

end
