class ItemsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @categories = Category.where(user_id: current_user.id).order("category_list_id ASC")
    @item = ItemWithInformation.new
    @items = Item.where(user_id: current_user.id).includes(:item_informations)
  end

  def create
    if ItemWithInformation.singular_save(item_params)
      flash[:success] = "保存に成功しました"
    else
      flash[:error] = "保存に失敗しました"
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item_with_information).permit(:name, :unit, :quantity_total, :category_id, :deadline, :purchase_date, :quantity, :is_frozen, :item_id).merge(user_id: current_user.id)
  end
end
