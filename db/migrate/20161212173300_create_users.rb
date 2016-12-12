class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    create_table :users do |t|
      t.citext :email, null: false, index: true
      t.string :token, null: false
      t.boolean :is_suppressed, default: false, null: false
      t.datetime :invited_at, null: false
      t.datetime :activated_at

      t.timestamps
    end
  end
end
