class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false, index: true
      t.citext :mailgun_id
      t.integer :message_type, null: false, default: 0
      t.citext :subject
      t.citext :content
      t.datetime :opened_at

      t.timestamps
    end
  end
end
