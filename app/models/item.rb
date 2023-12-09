class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :items_status
  belongs_to :shipping_cost

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :items_status_id
    validates :shipping_cost
  end
end
