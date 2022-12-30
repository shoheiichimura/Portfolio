class Public::ReportsController < ApplicationController
  before_action :authenticate_customer!
  def new
    #新しい通報の箱を用意
    @report = Report.new
    #どのユーザーに対する通報なのかparamsで取得する
    @customer = Customer.find(params[:customer_id])
  end

  def create
    #どのユーザーに対する通報なのかparamsで取得する
    @customer = Customer.find(params[:customer_id])
     #ストロングパラメータを通す
    @report = Report.new(report_params)
    #通報者(reporter_id)にcurrent_customer.idを代入
    @report.reporter_id = current_customer.id
    #通報される人(reported_id)に上で取得した@customer.idを代入
    @report.reported_id = @customer.id
     #保存する
    if @report.save
      redirect_to customer_path(@customer), notice: "ご報告ありがとうございます。"
    else
      @customer = Customer.find(params[:customer_id])
      render "new"
    end
  end

  private

  def report_params
    params.require(:report).permit(:reason, :url)
  end
end
