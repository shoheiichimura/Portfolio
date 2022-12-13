class Public::CustomersController < ApplicationController
   before_action :search_customer, only: [:index]
   before_action :ensure_guest_user, only: [:edit]

  def index
    @q = Customer.ransack(params[:q])  # 検索オブジェクトを生成
    @results = @q.result
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
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

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def customer_params
  params.require(:customer).permit(:name,:introduction, :email,:sex,:profile_image,:active_area,:objective,:frequency,:heart,:traning_style)
  end

  def search_customer
    @q = Customer.ransack(params[:q])  # 検索オブジェクトを生成
    @results = @q.result
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
