class CreateViews < ActiveRecord::Migration[5.1]
  def change
    create_table :views do |t|
      t.references :user, null: false
      t.string :list_type, null: false
      t.string :list_id, null: false
      t.string :sort_order
      t.string :video_id
      t.timestamps
      t.index [:list_type, :list_id]
      t.index :updated_at
    end
  end
end
