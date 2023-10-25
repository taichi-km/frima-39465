class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|

      t.string :string, null: false

      t.timestamps
    end
  end
end
