class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 画像を使用するための記述を追加します
  has_one_attached :profile_image       
  has_many :books, dependent: :destroy
end
