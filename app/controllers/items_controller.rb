class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy, :value_input]
  before_action :set_category_id, only: [:add_form, :remove_form]
  before_action :set_items, only: [:add_form]
  
  def index
    @categories = current_user.categories.order("category_list_id ASC").all.includes(items: [:item_informations])
    sql1 = "SELECT item_id, SUM(quantity) AS quantity_total FROM item_informations WHERE user_id = #{current_user.id} GROUP BY item_id HAVING COUNT(item_id) > 1"
    @sum_quantities = ItemInformation.find_by_sql(sql1)
    @item = ItemWithInformation.new
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

  def edit
  end

  def update
    if @item.update(update_params)
      flash[:success] = "編集が完了しました"
    else
      flash[:error] = "編集に失敗しました"
    end
    redirect_to root_path
  end

  def destroy
    @item.destroy
  end

  def value_input
  end

  def add_form
  end

  def remove_form
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_category_id
    @category_id = params[:id]
  end

  def set_items
    @item = ItemWithInformation.new
    @items = current_user.items.where(category_id: @category_id).includes(:item_informations)
  end

  def item_with_information_params
    params.require(:item_with_information).permit(:name, :unit, :category_id, :deadline, :purchase_date, :quantity, :is_frozen).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :unit, :category_id).merge(user_id: current_user.id)
  end
end
