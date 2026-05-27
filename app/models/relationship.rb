class Relationship < ApplicationRecord
  # follower_id に紐づくユーザー
  belongs_to :follower, class_name: "User"
  # followed_id に紐づくユーザー
  belongs_to :followed, class_name: "User"
end
