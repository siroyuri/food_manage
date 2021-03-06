class Category < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
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

  def self.save_list(params)
    categories = []
    ActiveRecord::Base.transaction do
      params[:category_lists].each do |p|
        category = Category.new(p)
        category[:user_id] = params[:user_id]
        category.save!
        categories << category
      end
    end
      return categories
    rescue => e
      return false
  end
end
