class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :user, foreign_key: true
      t.string :description
      t.datetime :due_date
      t.boolean :completed?

      t.timestamps
    end
  end
end
