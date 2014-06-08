class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 10 }
  
  def self.most_popular
    Article.order("views_count DESC").first
  end
  
end
