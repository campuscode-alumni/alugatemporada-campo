FactoryBot.define do
  factory :proposal do
    name "MyString"
    email "MyString"
    phone "MyString"
    rent_purpose "MyText"
    total_guest 1
    start_date "2018-03-08"
    end_date "2018-03-08"
    pet false
    smoker false
    total_amount "9.99"
    details "MyText"
    property
  end
end
