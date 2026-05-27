class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  # Email address alias for specs that use user[email_address]
  def email_address
    email
  end

  def email_address=(value)
    self.email = value
  end

  # 画像を使用するための記述を追加します
  has_one_attached :profile_image       
  has_many :books, dependent: :destroy

  # 画像を表示するためのメソッドを追記
  def get_profile_image(width, height)
  # 画像があるか確認し、なければデフォルト画像を返す
    unless profile_image.attached?
      return 'default-image.jpg'
    end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
