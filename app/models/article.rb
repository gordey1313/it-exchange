class Article < ApplicationRecord
    include Visible
  
    has_many :comments, dependent: :destroy
  
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
    
    scope :sorted, -> { order(published_at: :desc, updated_at: :desc)}
    scope :draft, -> { where(published_at: nil)}
    scope :published, -> { where("published_at <= ?", Date.current)}
    scope :scheduled, -> { where("published_at > ?", Date.current)}

    def draft?
        published_at.nil?
    end

    def published?
        published_at? && published_at <= Date.current
    end

    def schedule?
        published_at? && published_at > Date.current
    end

end

