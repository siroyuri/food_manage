class Category < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_list

  private

  def self.save_from_list(params)
    params[:category_list_id].each do |category_list_id|
      Category.create(name: params[:name], category_list_id: category_list_id, user_id: params[:user_id])
    end
  end
end
