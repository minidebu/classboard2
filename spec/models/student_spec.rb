require 'rails_helper'

RSpec.describe Student, type: :model do
  before do
    @student = FactoryBot.build(:student)
  end

  describe "生徒の登録"do
    context "生徒が登録できる時" do
      it '入力が正しい時、生徒が登録される。'do
        expect(@student).to be_valid
      end
    end
    context "生徒が登録できない時"  do
      it "名前の入力がない時生徒を登録できない" do
        @student.name = ''
        @student.valid?
        expect(@student.errors.full_messages).to include("Name can't be blank")
      end

      it "カナの入力がない時生徒を登録できない" do
        @student.kana_name = ''
        @student.valid?
        expect(@student.errors.full_messages).to include("Kana name can't be blank")
      end

      it "カナの入力が全角カナでない時生徒を登録できない" do
        @student.kana_name = "あいえお"
        @student.valid?
        expect(@student.errors.full_messages).to include("Kana name 全角カナを入力してください")
      end

      it '誕生日が空があれば、ユーザー登録ができない' do
        @student.birth_on = "--/--/--"
        @student.valid?
        expect(@student.errors.full_messages).to include("Birth on can't be blank")
      end
    end
  end
end
