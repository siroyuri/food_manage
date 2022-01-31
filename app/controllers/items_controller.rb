class ItemsController < ApplicationController
  def index
    @categories = Category.where(user_id: current_user.id).order("category_list_id ASC")
  end
end
