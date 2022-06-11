# アプリケーション名
CLASS BOARD  
# アプリケーション概要
習い事を運営している人の予約や生徒管理することができる。  
# URL
https://classboard2.herokuapp.com/
# テスト用アカウント
CLASS BOARD
- メールアドレス：aa@aa
- パスワード：111111
# 利用方法
### お稽古の登録
1.トップページ(カレンダーページ)のヘッダーの設定を押す。  
2.(左側)お稽古名を入力し、登録を押す。  
3.(右側)１か月のお稽古パターンを選択し、登録を押す。  
### 生徒の登録
1.トップページ(カレンダーページ)のヘッダーの生徒・入会登録を押す。  
2.フリガナ(全角カナのみ)と名前、生年月日を入力し登録ボタンを押す。詳細画面に繊維する。  
3.お稽古登録するボタンを押す。  
4.曜日・時間・開始月・お稽古パターンを選択し変更ボタンを押す。  
### お稽古情報の変更
1.トップページ(カレンダーページ)のヘッダーの生徒・一覧詳細を押す。  
2.変更したい生徒の詳細のリンクを押す。  
3.退会の場合、退会月を入力し登録を押す。  
4.お稽古登録するボタンを押す。  
5.曜日・時間・開始月・お稽古パターンを選択し変更ボタンを押す。  
# アプリケーションを作成した背景
知人が書道教室を運営しており、紙媒体での予約管理に手間がかかり困っていた。
パソコンやスマートフォンで管理できれば合理的だと思い作成した。
# 実装した機能についての画像やGIF及びその説明
 - お稽古の登録機能
   生徒は事前に登録したお稽古パターンと紐付けをする。
   お稽古パターンは設定から増やすことできる。
   [![Image from Gyazo](https://i.gyazo.com/954deb9148c4ddd359dfc2ac9d5d2798.png)](https://gyazo.com/954deb9148c4ddd359dfc2ac9d5d2798)
 - カレンダー表示機能
   お稽古がある日はカレンダー上に開始時間、受講者の人数が表示される。
   [![Image from Gyazo](https://i.gyazo.com/a91234da11af4cf5b7bd60c68fac09bd.png)](https://gyazo.com/a91234da11af4cf5b7bd60c68fac09bd)  
 - 受講者表示機能
   日付をクリックすると、下部にお稽古の時間毎に受講者の一覧が表示される。
  [![Image from Gyazo](https://i.gyazo.com/64fa8cdd8f04f45f40c3d4a6390157de.gif)](https://gyazo.com/64fa8cdd8f04f45f40c3d4a6390157de)

# 実装予定の機能
・現在の画面を管理画面とし、生徒だけが使用する予約変更用の画面作成。
# データーベース設計
[![Image from Gyazo](https://i.gyazo.com/f05f4ab2766fae67b78c2d8546a0fefc.png)](https://gyazo.com/f05f4ab2766fae67b78c2d8546a0fefc)

# 環境開発
 - ruby
 - ruby on rails 
 - mysql
 - jquery

# ローカルでの動作方法
以下のコマンドを順に実行  
 % git clone https://github.com/minidebu/classboard2.git  
 % cd classboard2  
 % bundle install  
 % yarn install  
 % rails db:seed
