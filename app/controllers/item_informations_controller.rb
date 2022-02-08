class ItemInformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_info, only: [:edit, :update, :destroy]

  def edit
    @item = Item.find(@info.item_id)
  end

  def update
    @info.update(info_params)
    redirect_to root_path
  end

  def destroy
    @info.destroy
    redirect_to root_path
  end

  private

  def set_info
    @info = ItemInformation.find(params[:id])
  end

  def info_params
    params.require(:item_information).permit(:item_id, :quantity, :deadline, :purchase_date).merge(user_id: current_user.id)
  end
end
