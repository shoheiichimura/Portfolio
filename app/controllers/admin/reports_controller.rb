class Admin::ReportsController < ApplicationController
  before_action :authenticate_admin!
  def index
    #全ての通報を取得
    @reports = Report.page(params[:page]).per(10)
  end

  def show
    #特定の通報IDを取得
    @report = Report.find(params[:id])
    @reported = @report.reported.id
    @reporter = @report.reporter.id
  end

  def update
    @report = Report.find(params[:id])
    #ストロングパラメータを通して更新
    if @report.update(report_params) 
      flash[:notice] = "対応ステータスを更新しました。"
      redirect_to request.referer
    end
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end
end
