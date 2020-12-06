class Task < ApplicationRecord
    has_many :comments
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    validates :title, :content, presence: true
    has_rich_text :content
    acts_as_votable
end
