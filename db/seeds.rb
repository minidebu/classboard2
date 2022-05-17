# 既存のユーザーを全削除
User.delete_all

# ユーザーを登録
User.create!(password: "111111", email: "aa@aa")
Student.create!(name: "松本", kana_name: "マツモト",birth_on:"1985/10/19" )
