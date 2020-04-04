class AddBalanceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance, :decimal, :default => 0.00, :precision => 7, :scale => 2
  end
end
