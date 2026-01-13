class CreateSubscribers < ActiveRecord::Migration[8.0]
  def change
    create_table :subscribers do |t|
      t.string :email, null: false
      t.datetime :subscribed_at, null: false, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end

    add_index :subscribers, :email, unique: true
  end
end
