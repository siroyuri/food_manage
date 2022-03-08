require 'rails_helper'

RSpec.describe Category, type: :model do
  before do
    @category_non_zero = FactoryBot.build(:category)

    @category_zero = FactoryBot.build(:category)
    @category_zero.category_list_id = "0"
    @category_zero.name = '1234567890'
  end

  describe 'カテゴリー追加機能【category_list_idが0以外の時】' do
    context 'カテゴリーの追加ができる' do
      it 'nameの値が正しければ追加できる' do
        expect(@category_non_zero).to be_valid
      end
      it '違うユーザーであればcategory_list_idに同じ値を追加できる' do
        @category_non_zero.save
        @another_user_category = FactoryBot.build(:category)
        expect(@another_user_category).to be_valid
      end
    end
    context 'カテゴリーの追加ができない' do
      it 'nameに値の入力があると追加出来ない' do
        @category_non_zero.name = '1234567890'
        @category_non_zero.valid?
        expect(@category_non_zero.errors.full_messages).to include("Nameは入力しないでください")
      end
      it 'category_list_idはリストのid（１〜１６）でないと追加出来ない' do
        @category_non_zero.category_list_id = "17"
        @category_non_zero.valid?
        expect(@category_non_zero.errors.full_messages).to include("Category listis invalid")
      end
      it 'category_list_idは同じ値を追加出来ない' do
        @category_non_zero.save
        @category_same_id = FactoryBot.build(:category)
        @category_same_id.user = @category_non_zero.user
        @category_same_id.valid?
        expect(@category_same_id.errors.full_messages).to include("Category listhas already exists")
      end
    end
  end

  describe 'カテゴリー追加機能【category_list_idが0の時】' do
    context 'カテゴリーの追加ができる' do
      it 'nameの値が正しければ追加できる' do
        expect(@category_zero).to be_valid
      end
      it 'category_list_idに同じ値を追加できる' do
        @category_zero.save
        @category_same_id = FactoryBot.build(:category)
        @category_same_id.name = @category_zero.name
        @category_same_id.category_list_id = @category_zero.category_list_id
        @category_same_id.user = @category_zero.user
        expect(@category_same_id).to be_valid
      end
    end
    context 'カテゴリーの追加ができない' do
      it 'nameが空だと追加出来ない' do
        @category_zero.name = ''
        @category_zero.valid?
        expect(@category_zero.errors.full_messages).to include("Nameを入力してください")
      end
      it 'nameは10文字以上だと追加出来ない' do
        @category_zero.name = '12345678901'
        @category_zero.valid?
        expect(@category_zero.errors.full_messages).to include("Nameis enter within 10 characters")
      end
    end
  end

  describe 'カテゴリー追加機能【共通部分】' do
    context 'カテゴリーの追加ができない' do
      it 'category_list_idが空だと追加できない' do
        @category_non_zero.category_list_id = ''
        @category_non_zero.valid?
        expect(@category_non_zero.errors.full_messages).to include("Category listを入力してください")
      end
      it 'category_list_idは数字以外を追加出来ない' do
        @category_non_zero.category_list_id = 'a'
        @category_non_zero.valid?
        expect(@category_non_zero.errors.full_messages).to include("Category listis enter a number")
      end
      it 'userが紐づいていないと追加出来ない' do
        @category_non_zero.user = nil
        @category_non_zero.valid?
        expect(@category_non_zero.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end

# bundle exec rspec spec/models/category_spec.rb
