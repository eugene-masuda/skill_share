# skill-share
プログラミングを学習しているときに、メンターや質問できる人を探せるサービスがあれば便利だと思って作りました。  
メンターなどを探すだけでなく、webデザイナーを探したり、色々なスキルを持つ人を探すことができます。
[サイトはこちら](https://skill-share-prd.herokuapp.com)
***
# 環境
#### Development Environment  
MacOS  

#### Languages  
HTML  
CSS  
JavaScript  
Ruby(2.6.5)  
#### main framework
Ruby on Rails(6.0.2)

#### CSS framework
bulma

#### JavaScript library
jQuery  

#### DB
PostgreSQL  

#### Infrastructure
heroku  

#### Other
yarn
docker
circle ci
***

# 実装機能
#### プラン作成機能    
![giphy-プラン作成](https://user-images.githubusercontent.com/63545165/93014364-7f4b9180-f5eb-11ea-85e3-f59f95fd3199.gif)  
  
#### クレジットカード登録機能  
カード番号4242 4242 4242 4242 4242    
有効期限　適当に期限切れにならないように入力してください  
CVC番号　適当に入力してください  
![クレジットカード登録](https://user-images.githubusercontent.com/63545165/93174181-86e47500-f768-11ea-84d3-89d91a607275.gif)  

#### 購入機能  
![購入画面](https://user-images.githubusercontent.com/63545165/93177917-78995780-f76e-11ea-989b-2431af8bcc3d.gif)  

#### 購入後のやりとり  
![購入後のやりとりgif](https://user-images.githubusercontent.com/63545165/93179454-aaabb900-f770-11ea-9d5f-ae0cabfeab21.gif)  
ローカル環境では更新しなくてもコメントが反映されるのですが、本番環境だと更新しないとコメントが反映されないです。  

#### ユーザーにメッセージを送信する  
![ユーザーメッセージ](https://user-images.githubusercontent.com/63545165/93183037-738bd680-f775-11ea-89ad-3050c6fedcf6.gif)  
こちらもメッセージ送信後は更新しないと反映されないです。

#### 契約完了後の評価  
![評価　](https://user-images.githubusercontent.com/63545165/93184509-4c360900-f777-11ea-971a-0334a5174804.gif)  

#### サブスクリプション請求  
![サブスクリプション](https://user-images.githubusercontent.com/63545165/93185475-6b816600-f778-11ea-9fc7-b7928c0b1c3f.gif)  
***  
# 課題＆実装したい機能  
ローカル環境では上手く動いても、本番環境だと動作しないことがあり多々あり改善できたこともあったが、改善することができなく、いくつか機能を削除しなければならなかった。  
サブスクリプションを契約することによって、会計の際に手数料が変化する機能を追加したい。










