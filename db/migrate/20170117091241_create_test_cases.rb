class CreateTestCases < ActiveRecord::Migration[5.0]
  def change
    create_table :test_cases do |t|
      t.string :identifier, null: false
      t.string :issuer,     null: false
      t.timestamps
      t.index :identifier, unique: true
      t.index :issuer,     unique: true
    end
  end
end
