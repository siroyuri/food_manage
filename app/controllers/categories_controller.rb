class CategoriesController < ApplicationController
  def new
    @category = Category.new
    @categories = Category.where(user_id: current_user.id)
    @category_list = CategoryList.where.not(id: @categories.pluck(:category_list_id))
  end

  def create
    respond_to do |format|
      format.html {
        if params[:category].present?
          if Category.save_from_list(category_params)
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
        if params[:name].present?
          @new_category = Category.create(name: params[:name], category_list_id: 0, user_id: current_user.id)
        end
       }
    end
  end

  private

  def category_params
    params.require(:category).permit(category_list_id: []).merge(user_id: current_user.id, name: "")
  end
end
