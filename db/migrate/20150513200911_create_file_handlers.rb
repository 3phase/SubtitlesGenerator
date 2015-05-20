class CreateFileHandlers < ActiveRecord::Migration
  def change
    create_table :file_handlers do |t|

      t.timestamps null: false
    end
  end
end
