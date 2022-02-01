class Category < ApplicationRecord
  belongs_to :user
  has_many :items
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category_list

  with_options if: :new_category? do
    validates :name, length: { maximum: 10, message: "is enter within 10 characters" }, allow_blank: true
    validates :name, presence: true
  end
  with_options unless: :new_category? do
    validates :name, absence: true
    validates :category_list_id, uniqueness: { scope: :user, message: "has already exists" }
    validates :category_list_id, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 16, message: "is invalid" }, allow_blank: true
  end
  validates :category_list_id, numericality: { only_integer: true, message: "is enter a number" }, allow_blank: true
  validates :category_list_id, presence: true

  private

  def new_category?
    category_list_id == 0
  end

  def self.save_from_list(params)
    Category.transaction do
      params[:category_list_id].each do |category_list_id|
        Category.create!(name: params[:name], category_list_id: category_list_id, user_id: params[:user_id])
      end
    end
      return true
    rescue => e
      return false
  end
end
