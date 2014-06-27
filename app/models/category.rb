class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  
  before_save :update_slug
  
  def update_slug
    self.slug=self.name.downcase.gsub(" ","_")
  end
end
