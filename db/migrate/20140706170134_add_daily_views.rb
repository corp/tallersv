class AddDailyViews < ActiveRecord::Migration
  def change
    add_column :articles, :daily_views, :integer, :default=>0
  end
end
