class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :users do |t|
      t.citext :name, null: false
      t.citext :email, null: false, index: true
      t.string :token, null: false, unique: true, index: true
      t.boolean :is_suppressed, default: false, null: false
      t.datetime :invited_at, null: false
      t.datetime :reminder_sent_at
      t.datetime :activated_at

      t.timestamps
    end
  end
end
