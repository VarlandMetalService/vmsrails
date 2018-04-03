class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :employee_number, null: false, unique: true
      t.string :username, null: false, limit: 20, unique: true
      t.string :first_name, null: false
      t.string :middle_initial, limit: 1
      t.string :last_name, null: false
      t.string :suffix, null: true, default: nil, limit: 10
      t.string :nickname, null: false, unique: true
      t.string :initials, null: false, limit: 5
      t.string :email, null: false, unique: true
      t.string :avatar_bg_color, null: false, default: '#000000', limit: 7
      t.string :avatar_text_color, null: false, default: '#ffffff', limit: 7
      t.boolean :is_admin, default: false
      t.boolean :is_disabled, default: false
      t.string :remember_digest
      t.timestamps
    end
  end
end
