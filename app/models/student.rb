class Student < ApplicationRecord
  has_many :plans
  accepts_nested_attributes_for :plans ,allow_destroy: true
  
  validates :kana_name ,presence: true
  validates :name ,presence: true
  validates :birth_on ,presence: true
  validates :kana_name ,  format: { with: /\A[ァ-ヶー]+\z/, message: '全角カナを入力してください' }, allow_blank: true 
  validates :withdrawal_on ,presence: true ,on: :withdrawal_set



  

  def get_grade
    date_format = "%Y%m%d"
    age = get_age
    st_age = Date.new(self.birth_on.year,4,2)
    if self.birth_on.strftime('%m%d').to_i < "0402".to_i
      st_age = st_age.prev_year

    end
    grade= (Date.today.strftime(date_format).to_i - st_age.strftime(date_format).to_i)/10000 -1
    return grade
  end

  def get_age 
    date_format = "%Y%m%d"
    age = (Date.today.strftime(date_format).to_i - self.birth_on.strftime(date_format).to_i)/10000
  end

  def school_grade

    grade = get_grade
    grade_g = 0
    case  grade
      when 0..5
        grade_g = "小学生以下"
      when  6..11
        grade_g = "小学生#{grade-5}年生"
      when  12..14
        grade_g = "中学生#{grade-11}年生"
      else
        grade_g = "社会人"
    end

    return grade_g
  end
end
