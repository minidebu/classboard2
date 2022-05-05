class Student < ApplicationRecord
  validates :kana_name ,presence: true
  validates :name ,presence: true
  validates :birth_on ,presence: true
  validates :kana_name ,  format: { with: /\A[ァ-ヶー]+\z/, message: '全角カナを入力してください' }, allow_blank: true 

  def school_year()
    date_format = "%Y%m%d"
    age = get_age
    st_age = Date.new(birth_on.year,4,2)
    if birth_on.strftime('%m%d').to_i < "0402".to_i
      st_age = st_age.prev_year

    end
   
    grade= (Date.today.strftime(date_format).to_i - st_age.strftime(date_format).to_i)/10000 -1

  case  grade
    when 0..5
      grade_g = "小学生以下"
    when  6..12
      grade_g = "小学生#{grade-5}年生"
    when  13..15
      grade_g = "中学生#{grade-12}年生"
    else
      grade_g = "社会人"
  end

    return grade_g
  end

  def get_age 
    date_format = "%Y%m%d"
    age = (Date.today.strftime(date_format).to_i - self.birth_on.strftime(date_format).to_i)/10000
  end

end
