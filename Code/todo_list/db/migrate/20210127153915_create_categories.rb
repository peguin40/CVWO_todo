class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.belongs_to :task
      t.string :name
    end
  end
end
