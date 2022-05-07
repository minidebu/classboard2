require 'rails_helper'

RSpec.describe Student, type: :model do

  before do
    @student = FactoryBot.build(:student)
  end

  describe "生徒管理機能" do
    context "生徒の登録ができる" do
      it "入力が正常な時、生徒が登録できる" do
        expect(@student).to be_valid
      end
    end
    context "生徒の登録ができない" do
      it "名前を入力していなければ、生徒の登録ができない" do
        @student.name = ""
        @student.valid?
        expect(@student.errors.full_messages).to include("Name can't be blank")
   

      end
      it "カナを入力していなければ、生徒の登録ができない" do
        @student.kana_name = ""
        @student.valid?
        expect(@student.errors.full_messages).to include("Kana name can't be blank")


      end
      it "誕生日を入力していなければ、生徒の登録ができない" do
        @student.birth_on = ""
        @student.valid?
        expect(@student.errors.full_messages).to include("Birth on can't be blank")

      end
      it "カナに全角カタカナ以外の文字を入力していれば、生徒の登録ができない" do
        @student.kana_name = "あいうえお"
        @student.valid?
        expect(@student.errors.full_messages).to include("Kana name 全角カナを入力してください")
      end
    end

    context "退会登録" do
      it "退会日を正常に入力すれば、退会登録ができる" do
        @student.withdrawal_on = Faker::Date.between(from: 5.days.ago, to: Date.today)
        expect(@student).to be_valid
      end
    end


  end
end
