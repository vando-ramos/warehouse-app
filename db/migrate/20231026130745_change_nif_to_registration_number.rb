class ChangeNifToRegistrationNumber < ActiveRecord::Migration[7.1]
  def change
    rename_column :suppliers, :nif, :registration_number
  end
end
