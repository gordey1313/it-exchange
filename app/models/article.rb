class Article < ApplicationRecord
    include Visible
  
    has_many :comments, dependent: :destroy
  
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }
    
    scope :draft, -> { where(published_at:nil)}
    scope :published, -> { where("published_at <= ?", Date.current)}
    scope :scheduled, -> { where("published_at > ?", Date.current)}

    def draft?
        publihed_at.nil?
    end

    def publihed?
        publihed_at? && publihed_at <= Date.current
    end

    def schedule?
        publihed_at? && publihed_at > Date.current
    end

end

