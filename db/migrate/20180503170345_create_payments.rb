class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.decimal :amount, precision: 8, scale: 2
      t.timestamps
      t.integer :loan_id
      t.date :payment_date
    end
  end
end