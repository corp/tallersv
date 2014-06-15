class ArticleMailer < ActionMailer::Base
  default from: "info@tallersv.com"
  
  def article_published(article)
      @article = article
      mail(to: @article.user.email, subject: 'Your article is ready, share it with the world...')
  end
  
end
