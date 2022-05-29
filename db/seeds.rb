# 既存のユーザーを全削除
User.delete_all
Lesson.delete_all

# ユーザーを登録
Lesson.create!(name:"--")
User.create!(password: "111111", email: "aa@aa")    


