class CreateSingles < ActiveRecord::Migration[8.1]
  def change
    create_table :singles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.bigint :age
      t.text :gender
      t.text :status
      t.text :broker_number
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
