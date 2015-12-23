class CreateLink < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.belongs_to :tag
      t.belongs_to :node
      t.timestamps
    end
  end
end
