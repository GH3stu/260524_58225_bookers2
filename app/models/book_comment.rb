class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :comment, presence: true # コメントの内容が空（空文字）だったら保存を禁止
end
