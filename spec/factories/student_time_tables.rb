FactoryBot.define do
  factory :student_time_table do
    name   {"松本"}
    student_id  {}
    time_table_id  {}
    started_on     {Faker::Date.between(from: 5.days.ago, to: Date.today)}
    week_id        {rand(1..7)}
    st_time {}
    
  end
end


