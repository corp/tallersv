class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :views_count, :default=>0

      t.timestamps
    end
  end
end
