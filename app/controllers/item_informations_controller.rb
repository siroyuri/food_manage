class ItemInformationsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    info = ItemInformation.find(params[:id])
    info.destroy
    redirect_to root_path
  end
end
