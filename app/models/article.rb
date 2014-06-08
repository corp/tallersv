class Article < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 10 }
  
  def self.most_popular
    Article.order("views_count DESC").first
  end
  
end
