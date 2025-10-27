# README

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| nickname | string | NOT NULL | ニックネーム |
| email | string | NOT NULL, UNIQUE | メールアドレス |
| encrypted_password | string | NOT NULL | 暗号化されたパスワード |
| last_name | string | NOT NULL | 姓（全角） |
| first_name | string | NOT NULL | 名（全角） |
| last_name_kana | string | NOT NULL | 姓（カナ） |
| first_name_kana | string | NOT NULL | 名（カナ） |
| birthday | date | NOT NULL | 生年月日 |

**アソシエーション**  
- has_many :items  
- has_many :orders

---

### items テーブル（商品情報）

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| name | string | NOT NULL | 商品名 |
| description | text | NOT NULL | 商品の説明 |
| category_id | integer | NOT NULL | カテゴリー（ActiveHash） |
| condition_id | integer | NOT NULL | 商品の状態（ActiveHash） |
| shipping_charge_id | integer | NOT NULL | 配送料の負担（ActiveHash） |
| prefecture_id | integer | NOT NULL | 発送元地域（ActiveHash） |
| shipping_day_id | integer | NOT NULL | 発送までの日数（ActiveHash） |
| price | integer | NOT NULL | 価格 |
| user_id | references | NOT NULL, 外部キー: true | 出品者 |

**アソシエーション**  
- belongs_to :user  
- has_one :order

---

### orders テーブル（購入記録）

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| user_id | references | NOT NULL, 外部キー: true | 購入者 |
| item_id | references | NOT NULL, 外部キー: true | 購入された商品 |

**アソシエーション**  
- belongs_to :user  
- belongs_to :item  
- has_one :address

---

### addresses テーブル（発送先情報）

| カラム名 | 型 | 制約 | 説明 |
|-----------|----|------|------|
| postal_code | string | NOT NULL | 郵便番号（例: 123-4567） |
| prefecture_id | integer | NOT NULL | 都道府県（ActiveHash） |
| city | string | NOT NULL | 市区町村 |
| address | string | NOT NULL | 番地 |
| building | string |  | 建物名（任意） |
| phone_number | string | NOT NULL | 電話番号（ハイフンなし） |
| order_id | references | NOT NULL, 外部キー: true | 購入記録 |

**アソシエーション**  
- belongs_to :order

---

## 🔗 テーブル間の関係図（概要）

users ───< items
│ │
│ └───< orders ────< addresses
│
└──────────────────────────> orders

yaml
コードをコピーする
This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
