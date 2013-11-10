class DepartmentsController < ApplicationController
  skip_before_filter :authenticate_user!, [:show]

  def show
    @department = Department.find(params[:id])
    @dc = @department.categories
    @products = @department.products
  rescue ActiveRecord::RecordNotFound
    render :file => "#{Rails.root}/public/404"
  end
end