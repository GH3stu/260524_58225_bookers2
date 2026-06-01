class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  has_many :book_comments, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 追記：フォローされている側の情報を取得する設定
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  def self.search_for(content, method)
    if method == 'perfect_match'
      @user = User.where(name: content)
    elsif method == 'forward_match'
      @user = User.where('name LIKE ?', content + '%')
    elsif method == 'backward_match'
      @user = User.where('name LIKE ?', '%' + content)
    else
      @user = User.where('name LIKE ?', '%' + content + '%')
    end
  end
  # ★ フォローする
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  # ★ フォロー外す
  def unfollow(user)
    relationships.find_by(followed_id: user.id)&.destroy
  end

  # ★ フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

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
      return "default-image.jpg"
    end
  profile_image.variant(resize_to_limit: [ width, height ]).processed
  end
end
