class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  validates :image,                  presence: true
  validates :name,                   presence: true
  validates :info,                   presence: true
  validates :category_id,            numericality: { other_than: 1, message: "can't be blank" }
  validates :status_id,              numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,          numericality: { other_than: 1, message: "can't be blank" }
  validates :scheduled_delivery_id,  numericality: { other_than: 1, message: "can't be blank" }
  validates :price,                  presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  
end
