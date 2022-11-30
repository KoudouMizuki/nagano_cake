class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_dateils, dependent: :destroy
  has_one_attached :image
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  
  def with_tax_price
    (price*1.1).floor
  end
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/asets/images/no-image.jpg')
      image.attach(io: File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
end
