class ItemInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_info, only: [:edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update]

  def edit
  end

  def update
    @item_with_information = ItemWithInformation.new(update_params)
    if @item_with_information.update(@info, @item)
      flash[:success] = "編集が完了しました"
    else
      flash[:error] = "編集に失敗しました"
    end
    redirect_to root_path
  end

  def destroy
    @info.destroy
    redirect_to root_path
  end

  def is_frozen
    @info = ItemInformation.find(params[:id])
    @info.update(is_frozen: params[:is_frozen])
  end

  private

  def set_info
    @info = ItemInformation.find(params[:id])
  end

  def set_item
    @item = Item.find(@info.item_id)
  end

  def update_params
    params.require(:item_information).permit(:name, :unit, :category_id, :deadline, :purchase_date, :quantity, :is_frozen).merge(user_id: current_user.id)
  end
end
