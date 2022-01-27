class Category < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_list

  validates :name, length: { maximin: 10, message: "カテゴリー名は10文字以内で入力してください" }, allow_blank: true
  validates :category_list_id, uniqueness: { scope: :user, message: "同じカテゴリーは保存できません" }, unless: :add_new_list?
  validates :category_list_id, numericality: { only_integer: true, message: "idは数字のみ保存可能です" }

  private

  def add_new_list?
    category_list_id == 0
  end

  def self.save_from_list(params)
    params[:category_list_id].each do |category_list_id|
      Category.create(name: params[:name], category_list_id: category_list_id, user_id: params[:user_id])
    end
  end
end
