class CreateDomains < ActiveRecord::Migration[8.1]
  def change
    create_table :domains do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.datetime :expires_at
      t.datetime :last_checked_at

      t.timestamps
    end
  end
end
