# 既存のユーザーを全削除
User.delete_all

# ユーザーを登録

User.create!(password: "111111", email: "aa@aa")    
Lesson.create!(name:"--") 


