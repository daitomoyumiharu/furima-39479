class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions


  has_one    :order
  belongs_to :user
  has_one_attached :image

  belongs_to :category
  belongs_to :prefecture
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :shipping_date

  with_options presence: true do
    validates :image, presence: true
    validates :name, presence: true
    validates :description, presence: true
    validates :category_id, presence: true
    validates :item_status_id, presence: true
    validates :shipping_cost_id, presence: true
    validates :prefecture_id, presence: true
    validates :shipping_date_id, presence: true
    # 300円以上かつ9,999,999円以下で、半角数字でないと入力不可
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
  end
   
  # 選択が「--」の時(0の時)は保存不可のバリデーション
  validates :category_id,numericality: { other_than: 0 , message: "カテゴリーを選択してください" }
  validates :prefecture_id,numericality: { other_than: 0 , message: "都道府県を選択してください" }
  validates :item_status_id,numericality: { other_than: 0 , message: "商品の状態を選択してください" }
  validates :shipping_cost_id,numericality: { other_than: 0 , message: "配送料を選択してください" }
  validates :shipping_date_id,numericality: { other_than: 0 , message: "発送までの日数を選択してください" }

end
