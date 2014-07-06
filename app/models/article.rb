class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :categories
  
  belongs_to :user
  #after_create :notify_author
  
  validates :title, presence: true, length: { minimum: 10 }
  
  mount_uploader :photo, PhotoUploader
  
  def self.most_popular
    Article.order("views_count DESC").first
  end
  
  def notify_author
    ArticleMailer.article_published(self).deliver
  end
  
end
