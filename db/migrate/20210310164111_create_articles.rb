class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :title
      t.string :source

      t.timestamps
    end
  end
end
