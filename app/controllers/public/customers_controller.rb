class Public::CustomersController < ApplicationController
   before_action :search_customer, only: [:index]
   before_action :ensure_guest_user, only: [:update,]
   before_action :authenticate_customer!

  def index
    @q = Customer.page(params[:page]).per(12).order('created_at DESC').ransack(params[:q]) # 検索オブジェクトを生成
    @results = @q.result
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.page(params[:page]).per(4).order('created_at DESC')
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "更新完了しました！"
    else
      render "edit"
    end
  end

  def confirm
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , alert: 'ゲストユーザーは退会できません。'
    elsif  @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: '退会完了いたしました。'
    else
      redirect_to request.referer
    end
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
    @results = @q.result(distinct: true)
  end

  def ensure_guest_user
    customer = Customer.find(params[:id])
    if customer.name == "guestuser"
      redirect_to customer_path(current_customer) , alert: 'ゲストユーザーはプロフィール編集できません。'
    end
  end

end
