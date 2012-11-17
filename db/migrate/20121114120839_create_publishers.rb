class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|

      t.string :message

      t.timestamps
    end
  end
end
