class CreateAdmin < ActiveRecord::Migration[7.1]
  def change
    create_table :admins do |t|
      add_reference :events, :administrator, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
