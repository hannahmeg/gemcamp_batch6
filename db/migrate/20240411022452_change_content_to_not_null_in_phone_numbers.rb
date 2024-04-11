class ChangeContentToNotNullInPhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :phone_numbers, :content, false
  end
end
