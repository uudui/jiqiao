class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :status, default: 0
      t.integer :posts_count, default: 0

      t.timestamps
    end

    add_index :collections, :user_id

  end
end
