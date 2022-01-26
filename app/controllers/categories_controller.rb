class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @categories = Category.where(user_id: current_user.id)
    @category_list = CategoryList.where.not(id: @categories.pluck(:category_list_id))
  end

  def create
    if params[:category].present?
      Category.save_from_list(category_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def category_params
    params.require(:category).permit(category_list_id: []).merge(user_id: current_user.id, name: "")
  end
end
