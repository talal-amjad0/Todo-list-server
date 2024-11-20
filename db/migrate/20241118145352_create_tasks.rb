class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :task
      t.date :due_date
      t.string :status

      t.timestamps
    end
  end
end
