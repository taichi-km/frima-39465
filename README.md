# テーブル設計

## usersテーブル

| Column                    | Type   | Options                   |
| ------------------------- | ------ | ------------------------- |
| email                     | string | null: false, unique: true |
| encrypted_password        | string | null: false               |
| nickname                  | string | null: false               |
| name_last                 | string | null: false               |
| name_first                | string | null: false               |
| katakana_last             | string | null: false               |
| katakana_first            | string | null: false               |
| birthday                  | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| name                   | string     | null: false                    |
| info                   | text       | null: false                    |
| category_id            | integer    | null: false                    |
| status_id              | integer    | null: false                    |
| shipping_fee_status_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true | 
| item   | references | null: false, foreign_key: true | 

### Association

- belongs_to :item
- belongs_to :user
- has_one :shipping

## shippingsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| order         | references | null: false, foreign_key: true |

### Association

- belongs_to :order