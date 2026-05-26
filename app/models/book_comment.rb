class BookComment < ApplicationRecord
  belongs to :user
  belongs to :book
  validates :comment, presence: true # コメントの内容が空（空文字）だったら保存を禁止
end
