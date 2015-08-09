class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :content
      t.belongs_to :category

      t.timestamps null: false
    end
  end
end
