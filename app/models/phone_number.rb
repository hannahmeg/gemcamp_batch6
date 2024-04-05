class PhoneNumber < ApplicationRecord
  belongs_to :student

  attribute :number, :string
end
