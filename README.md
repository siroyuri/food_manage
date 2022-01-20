## usersテーブル
| Column             | Type   | option      |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association
- has_many :categories
- has_many :items
- has_many :favorites
- has_many :uses
- has_many :recipe_names


## categoriesテーブル
| Column           | Type       | option                         |
| ---------------- | ---------- | ------------------------------ |
| name             | string     |                                |
| category_list_id | integer    |                                |
| user             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :items
- has_many :uses


## itemsテーブル
| Column         | Type       | option                         |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| quantity_total | integer    | null: false                    |
| user           | references | null: false, foreign_key: true |
| category       | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :category
- has_many :item_informations
- has_many :favorites
- has_many :uses


## item_informationsテーブル
| Column        | Type       | option                         |
| ------------- | ---------- | ------------------------------ |
| deadline      | date       |                                |
| purchase_date | date       |                                |
| quantity      | integer    |                                |
| unit_id       | integer    |                                |
| item          | references | null: false, foreign_key: true |

### Association
- belongs_to :item


## favoritesテーブル
| Column | Type       | option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item


## usesテーブル
| Column   | Type       | option                         |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| quantity | integer    | null: false                    |
| status   | boolean    | null: false, default: false    |
| user     | references | null: false, foreign_key: true |
| category | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :category
- belongs_to :item


## recipe_namesテーブル
| Column | Type       | option                         |
| ------ | ---------- | ------------------------------ |
| name   | string     | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :recipe_materials


## recipe_materialsテーブル
| Column      | Type       | option                         |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| quantity    | integer    | null: false                    |
| recipe_name | references | null: false, foreign_key: true |

### Association
- belongs_to :recipe_name