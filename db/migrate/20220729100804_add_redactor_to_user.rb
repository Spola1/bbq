class AddRedactorToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :redactor, :boolean, default: false, null: false
  end
end
