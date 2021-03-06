class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category_id, only: [:add_form, :remove_form]
  
  def index
    @categories = current_user.categories.order("category_list_id ASC").all.includes(items: [:item_informations])
    sql1 = "SELECT item_id, SUM(quantity) AS quantity_total FROM item_informations WHERE user_id = #{current_user.id} GROUP BY item_id HAVING COUNT(item_id) > 1"
    @sum_quantities = ItemInformation.find_by_sql(sql1)
  end

  def create
    @item = ItemWithInformation.new(item_with_information_params)
    if @item.save
      flash[:success] = "保存に成功しました"
    else
      flash[:error] = @item.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end

  def add_form
    @item = ItemWithInformation.new
    @items = current_user.items.where(category_id: @category_id)
  end

  def remove_form
  end

  private

  def set_category_id
    @category_id = params[:id]
  end

  def item_with_information_params
    params.require(:item_with_information).permit(:name, :unit, :category_id, :deadline, :purchase_date, :quantity, :is_frozen).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :unit, :category_id).merge(user_id: current_user.id)
  end
end
