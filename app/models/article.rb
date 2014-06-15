class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  after_create :notify_author
  
  validates :title, presence: true, length: { minimum: 10 }
  
  def self.most_popular
    Article.order("views_count DESC").first
  end
  
  def notify_author
    ArticleMailer.article_published(self).deliver
  end
end
