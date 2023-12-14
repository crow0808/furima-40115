class DonationAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :block, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    # delivery_addressモデルのバリデーション
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    # orderモデルのバリデーション
    validates :item_id
    validates :user_id
  end
  # delivery_addressモデルのバリデーション
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
end
