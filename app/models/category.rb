class Category < ActiveRecord::Base
  has_and_belongs_to_many :articles
  
  before_save :generate_slug
  
  def generate_slug
    self.slug = self.name.downcase.gsub(" ","-")
  end
end
