class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.string :author
      t.references :article      
      t.timestamps
    end
  end
end
