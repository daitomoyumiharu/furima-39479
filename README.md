### users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false, unique: true |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

#### Association

- has_many :items
- has_many :orders
- has_many :comments

<br>

### items テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| users            | references | null: false, foreign_key: true |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| item_status_id   | integer    | null: false                    |
| shipping_cost_id | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| shipping_date_id | integer    | null: false                    |
| price            | integer    | null: false                    |

#### Association

- belongs_to :users
- has_one :order
- has_many :comments

<br>

### orders テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| items  | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :items
- has_one :payment

<br>

### payments テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| orders        | references | null: false, foreign_key: true |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

#### Association

- belongs_to :order

<br>

### comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
| text   | text       | null: false                    |

#### Association

- belongs_to :user
- belongs_to :item