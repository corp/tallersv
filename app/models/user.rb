class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  
  after_create :verify_articles
  
  private
  def verify_articles
    if User.count == 1
      Article.update_all(:user_id=>self.id)
      Comment.update_all(:user_id=>self.id)
    end
  end
  
end
