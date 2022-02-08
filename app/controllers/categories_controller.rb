class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
    @categories = Category.where(user_id: current_user.id)
    @category_list = CategoryList.where.not(id: @categories.pluck(:category_list_id))
  end

  def create
    respond_to do |format|
      format.html {
        if params[:category].present?
          if Category.save_from_list(category_list_params)
            flash[:success] = "保存に成功しました"
          else
            flash[:error] = "保存に失敗しました"
          end
          redirect_to root_path
        else
          redirect_to root_path
        end
                  }

      format.js {
        if params[:category][:name].present?
          @new_category = Category.create(category_input_params)
        end
       }
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
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { @category_id = params[:id] }
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_input_params
    params.require(:category).permit(:name).merge(category_list_id: 0, user_id: current_user.id)
  end

  def category_list_params
    params.require(:category).permit(category_list_id: []).merge(user_id: current_user.id, name: "")
  end
end
