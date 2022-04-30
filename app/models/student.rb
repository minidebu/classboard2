class Student < ApplicationRecord
  validates :kana_name ,presence: true
  validates :name ,presence: true
  validates :birth_on ,presence: true
  validates :kana_name ,  format: { with: /\A[ァ-ヶー]+\z/, message: '全角カナを入力してください' }, allow_blank: true 

end
