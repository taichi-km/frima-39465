# テーブル設計

## usersテーブル

| Column                    | Type   | Options                   |
| ------------------------- | ------ | ------------------------- |
| email                     | string | null: false, unique: true |
| encrypted_password        | string | null: false               |
| nickname                  | string | null: false               |
| name(last_name)           | string | null: false               |
| name(first_name)          | string | null: false               |
| katakana_name(last_name)  | string | null: false               |
| katakana_name(first_name) | string | null: false               |
| birthday                  | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| status              | text       | null: false                    |
| shipping_fee_status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | string     | null: false                    |
| seller              | references | null: false, foreign_key: true |
| buyer               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| buyer  | references | null: false, foreign_key: true | 
| item   | references | null: false, foreign_key: true | 

### Association

- belongs_to :item
- has_one :shipping

## shippingsテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null; false                    |
| building     | string     |                                |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order