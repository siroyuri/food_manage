class CategoryList < ActiveHash::Base
  self.data = [
    { id: 1, name: '肉・肉加工品' }, { id: 2, name: '野菜' },
    { id: 3, name: '魚介' }, {id: 4, name: '果物' },
    { id: 5, name: 'きのこ類' }, { id: 6, name: '豆・豆加工品' },
    { id: 7, name: '惣菜・調理品' }, { id: 8, name: 'パン・ジャム・シリアル' },
    { id: 9, name: 'お菓子・デザート' }, { id: 10, name: '飲料' },
    { id: 11, name: '乳製品' }, { id: 12, name: '調味料・食用油' },
    { id: 13, name: 'タレ・ソース・ドレッシング' }, { id: 14, name: 'ルー' },
    { id: 15, name: '缶詰・瓶詰' }, { id: 16, name: 'インスタント食品' }
  ]

  include ActiveHash::Associations
  has_many :categories
end