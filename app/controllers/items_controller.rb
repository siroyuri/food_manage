class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :destroy, :value_input]
  before_action :set_category_id, only: [:add_form, :remove_form, :switching_forms]
  before_action :set_items, only: [:add_form, :switching_forms]
  
  def index
    @categories = Category.where(user_id: current_user.id).order("category_list_id ASC")
    @item = ItemWithInformation.new
    sql1 = "SELECT item_id, SUM(quantity) AS quantity_total FROM item_informations GROUP BY item_id HAVING COUNT(item_id) > 1"
    @sum_quantities = ItemInformation.find_by_sql(sql1)
    @multi_items = Item.where(user_id: current_user.id, id: @sum_quantities.pluck(:item_id)).includes(:item_informations).order("category_id ASC")
    sql2 = "SELECT * FROM items WHERE id IN (SELECT item_id FROM item_informations GROUP BY item_id HAVING COUNT(item_id) = 1)"
    @single_items = Item.find_by_sql(sql2)
  end

  def create
    if ItemWithInformation.singular_save(item_params)
      flash[:success] = "保存に成功しました"
    else
      flash[:error] = "保存に失敗しました"
    end
    redirect_to root_path
  end

  def edit
  end

  def update
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def value_input
  end

  def add_form
  end

  def remove_form
  end

  def switching_forms
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
    @items = Item.where(user_id: current_user.id, category_id: @category_id).includes(:item_informations)
  end

  def item_params
    params.require(:item_with_information).permit(:name, :unit, :quantity_total, :category_id, :deadline, :purchase_date, :quantity, :is_frozen, :item_id).merge(user_id: current_user.id)
  end
end
