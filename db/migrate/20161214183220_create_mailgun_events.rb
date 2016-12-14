class CreateMailgunEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :mailgun_events do |t|
      t.belongs_to :message, index: true, null: false
      t.integer :event, null: false
      t.jsonb :data, default: '{}', null: false
      t.timestamps
    end

    add_index :mailgun_events, :data, using: :gin
  end
end
