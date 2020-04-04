class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      # t.decimal :balance, default: 0.00, precision: 7, scale: 2
    end
  end
end
