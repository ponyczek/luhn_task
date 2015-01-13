class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.string :provider
      t.string :validation

      t.timestamps
    end
  end
end
