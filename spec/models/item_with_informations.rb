require 'rails_helper'

RSpec.describe ItemWithInformation, type: :model do
  before do
    user = FactoryBot.create(:user)
    category = FactoryBot.create(:category)
    @item_with_information = FactoryBot.build(:item_with_information, user_id: user.id, category_id: category.id)
  end

  describe '食材情報の登録' do
    context '登録できる場合' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@item_with_information).to be_valid
      end
      it 'unitは空でも登録できる' do
        @item_with_information.unit = ''
        expect(@item_with_information).to be_valid
      end
      it 'deadlineは空でも登録できる' do
        @item_with_information.deadline = ''
        expect(@item_with_information).to be_valid
      end
    end

    context '登録できない場合' do
      it 'nameが空では登録できない' do
        @item_with_information.name = ''
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Nameを入力してください")
      end
      it 'nameは10文字以内でないと登録出来ない' do
        @item_with_information.name = '12345678901'
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Nameは10文字以内で入力してください")
      end
      it 'quantityが空では登録できない' do
        @item_with_information.quantity = ''
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Quantityを入力してください")
      end
      it 'quantityは0以下だと登録出来ない' do
        @item_with_information.quantity = 0
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Quantityis invalid")
      end
      it 'unitは3文字以内でないと登録できない' do
        @item_with_information.unit = '1234'
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Unitは3文字以内で入力してください")
      end
      it 'purchase_dateが空では登録できない' do
        @item_with_information.purchase_date = ''
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Purchase dateを入力してください")
      end
      it 'is_frozenが空では登録出来ない' do
        @item_with_information.is_frozen = ''
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Is frozenは一覧にありません")
      end
      it 'userが紐づいていないと登録出来ない' do
        @item_with_information.user_id = nil
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Userを入力してください")
      end
      it 'categoryが紐づいていないと登録出来ない' do
        @item_with_information.category_id = nil
        @item_with_information.valid?
        expect(@item_with_information.errors.full_messages).to include("Categoryを入力してください")
      end
    end
  end
end

# bundle exec rspec spec/models/item_with_informations.rb
