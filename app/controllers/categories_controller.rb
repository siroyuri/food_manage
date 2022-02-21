class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
    @categories = current_user.categories
    @category_list = CategoryList.where.not(id: @categories.pluck(:category_list_id))
  end

  def create
    if params[:category].present?
      @new_category = Category.save_list(category_params)

      respond_to do |format|
        format.html {
            if @new_category == false
              flash[:error] = ["保存に失敗しました"]
            else
              flash[:success] = "保存に成功しました"
            end
            redirect_to root_path
        }
  
        format.js {
          @category = Category.new
          @categories = current_user.categories.order("category_list_id ASC").includes(:items)
          category_list_id = @categories.pluck(:category_list_id).uniq
          @category_list = CategoryList.where.not(id: category_list_id)
        }
      end
    end
  end

  def edit
  end

  def update
    @category.update(category_input_params)
    redirect_to root_path
  end

  def destroy
    @category.destroy
  end

  private


  def set_category
    @category = Category.find(params[:id])
  end

  def category_input_params
    params.require(:category).permit(:name).merge(category_list_id: 0, user_id: current_user.id)
  end

  def category_params
    params.require(:category).permit(category_lists: [:category_list_id, :name]).merge(user_id: current_user.id)
  end
end
