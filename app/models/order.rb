class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_dateils, dependent: :destroy

  enum peyment_type: { credit_card: 0, transfer: 1}

  def postage
    800
  end
end
