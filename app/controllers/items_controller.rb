class ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.where(user_id: current_user.id).order("category_list_id ASC")
    @item = ItemWithInformation.new
    sql = "SELECT item_id, SUM(quantity) AS quantity_total FROM item_informations GROUP BY item_id HAVING COUNT(item_id) > 1"
    @sum_quantities = ItemInformation.find_by_sql(sql)
    @multi_items = Item.where(user_id: current_user.id, id: @sum_quantities.pluck(:item_id)).includes(:item_informations).order("category_id ASC")
    @single_items = Item.where(user_id: current_user.id).where.not(id: @sum_quantities.pluck(:item_id)).includes(:item_informations).order("category_id ASC")
  end

  def create
    if ItemWithInformation.singular_save(item_params)
      flash[:success] = "保存に成功しました"
    else
      flash[:error] = "保存に失敗しました"
    end
    redirect_to root_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  def value_input
    @item = Item.find(params[:id])
  end

  def add_form
    @item = ItemWithInformation.new
    @category_id = params[:id]
    @items = Item.where(user_id: current_user.id, category_id: @category_id).includes(:item_informations)
  end

  def remove_form
    @category_id = params[:id]
  end

  def switching_forms
    @item = ItemWithInformation.new
    @category_id = params[:id]
    @items = Item.where(user_id: current_user.id, category_id: @category_id).includes(:item_informations)
  end

  private

  def item_params
    params.require(:item_with_information).permit(:name, :unit, :quantity_total, :category_id, :deadline, :purchase_date, :quantity, :is_frozen, :item_id).merge(user_id: current_user.id)
  end
end
