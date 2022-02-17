class ItemInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_data, only: [:edit, :update, :destroy]

  def new
    @item = Form::ItemCollection.new
    @categories = current_user.categories.order("category_list_id ASC").includes(:items)
  end

  def create
    binding.pry
    @item = Form::ItemCollection.new(item_collection_params)
    if @item.save(params[:form_item_collection][:purchase_date], current_user.id)
      flash[:success] = "保存に成功しました"
    else
      flash[:error] = ["保存に失敗しました"]
    end
    redirect_to root_path
  end

  def edit
  end

  def update
    @item_with_information = ItemWithInformation.new(update_params)
    if @item_with_information.update(@info, @item)
      flash[:success] = "編集が完了しました"
    else
      flash[:error] = ["編集に失敗しました"]
    end
    redirect_to root_path
  end

  def destroy
    @info.destroy
    sql1 = "SELECT item_id, SUM(quantity) AS quantity_total FROM item_informations WHERE user_id = #{current_user.id} AND item_id = #{@item.id}"
    @sum_quantities = ItemInformation.find_by_sql(sql1)
  end

  def is_frozen
    @info = ItemInformation.find(params[:id])
    @info.update(is_frozen: params[:is_frozen])
  end

  private

  def set_item_data
    @info = ItemInformation.find(params[:id])
    @item = Item.find(@info.item_id)
  end

  def update_params
    params.require(:item_information).permit(:name, :unit, :category_id, :deadline, :purchase_date, :quantity, :is_frozen).merge(user_id: current_user.id)
  end

  def item_collection_params
    params.require(:form_item_collection).permit(informations_attributes: [:name, :unit, :category_id, :deadline, :quantity, :is_frozen])
  end
end
