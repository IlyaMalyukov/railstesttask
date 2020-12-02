class Task < ApplicationRecord
    validates :title, :content, presence: true
    has_rich_text :content
end
