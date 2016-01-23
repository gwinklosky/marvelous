class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :key
      t.boolean :admin
      t.boolean :published

      t.timestamps
    end
  end
end
