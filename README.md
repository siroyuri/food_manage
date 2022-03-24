# アプリケーション名
Food Manage

# アプリケーション概要
食材の在庫管理ができます。
カテゴリー別に分類して管理します。

# URL
https://food-manage.herokuapp.com/

# テスト用アカウント
Email：te@te
Password：111qqq

# 利用方法
ユーザー登録後、トップページの「カテゴリーを追加」から、新しいカテゴリーを追加、  
追加したカテゴリー枠内「＋」を押して出てくるフォームから、食材を１つ追加、  
「食材をまとめて追加」から、食材を複数追加ができます。  
それぞれ、トップページから削除、編集が可能です。  

# 目指した課題解決
買い物に出て、在庫があるのに買ってしまったり、在庫がないのに買わなかったり...  
帰ってから気付くこともあるかと思います。  
家にある食材をカテゴリー別に分けて管理することで、こういった失敗をなくすことを目標にしています。

# 洗い出した要件
スプレッドシートにまとめました。  
[要件定義スプレッドシート](https://docs.google.com/spreadsheets/d/1g0S5l1Ady7FH6WSfUIC6XPzJd1aQeRmtmIiMpUDSPp8/edit#gid=282075926)

# 実装した機能についての説明
## ユーザー管理機能
[![Image from Gyazo](https://i.gyazo.com/733cede0bae8c51dea5df6752d294256.gif)](https://gyazo.com/733cede0bae8c51dea5df6752d294256)
名前、メールアドレス、パスワードを使用してアカウントを作成できます。  
登録済みであれは、ログインページからメールアドレスとパスワードを使用してログインできます。
ログアウトボタンはヘッダーに表示されるので基本どのページからでもログアウトできます。

## カテゴリー追加機能
[![Image from Gyazo](https://i.gyazo.com/3facfca94a122dc898b34c1825d69172.gif)](https://gyazo.com/3facfca94a122dc898b34c1825d69172)
「野菜」「肉」などの大枠を追加できます。  
あらかじめ用意されたリストから選ぶ「選択式」と、オリジナルのカテゴリーを作成できる「入力式」があります。

## 食材追加機能
[![Image from Gyazo](https://i.gyazo.com/64a2d5272e8cba0e968a322f973dac76.gif)](https://gyazo.com/64a2d5272e8cba0e968a322f973dac76)
[![Image from Gyazo](https://i.gyazo.com/c5d8662234ea82533f47a40ed8665668.gif)](https://gyazo.com/c5d8662234ea82533f47a40ed8665668)
トップページから追加できます。  
食材の「名前」「数量」「単位」「賞味/消費期限」「購入日」を登録します。  
在庫がある食材はリストに表示され、リストを選択すると「名前」「単位」が自動で入力されます。

## 一覧表示機能
[![Image from Gyazo](https://i.gyazo.com/b928ecb6f9efb852923e1a6d5a60d76e.gif)](https://gyazo.com/b928ecb6f9efb852923e1a6d5a60d76e)
トップページになります。  
追加した食材がカテゴリー別に分けて表示されます。

## 食材の複数追加機能
[![Image from Gyazo](https://i.gyazo.com/2633808ba735d6ef111ba410730f30f7.gif)](https://gyazo.com/2633808ba735d6ef111ba410730f30f7)
[![Image from Gyazo](https://i.gyazo.com/0ab35cfec83bae31b33b29f1b79797b2.gif)](https://gyazo.com/0ab35cfec83bae31b33b29f1b79797b2)
食材を複数同時に追加できます。  
「別の食材を追加」を押すことでフォームを増やせます。
[![Image from Gyazo](https://i.gyazo.com/75d6fe7ffa36d5f55a6d0408ed6a1f10.gif)](https://gyazo.com/75d6fe7ffa36d5f55a6d0408ed6a1f10)
ここからカテゴリーの追加も可能です。  
画面遷移は行われないので入力内容が消えることもありません。

# 実装予定の機能
## 使用する食材の登録機能
現時点では、消費した食材は編集・削除をして在庫から削除する仕様になっています。  
使用する食材の名前、数量を登録することで、在庫から差し引いてくれる機能を考えています。

## お気に入り機能
食材追加時に表示されるリストには、在庫が存在する食材が表示されています。  
よく購入する食材でも、在庫がなければ表示されません。  
お気に入りに入れることで、在庫がなくてもリストに表示されるような機能を考えています。

## レシピ登録機能
料理に使う食材を「使用する食材リスト」として登録しているのであれば、同じリストを再度作成する可能性が考えられます。  
このリストをレシピとして登録しておくことで、同じリストを作成することがなくなるような機能を考えています。

# データベース設計
現時点でのER図です。  
[![Image from Gyazo](https://i.gyazo.com/c17d382d36af779974f48ff1751b7c9e.png)](https://gyazo.com/c17d382d36af779974f48ff1751b7c9e)

# ローカルでの動作方法
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-darwin20]  
Rails 6.0.4.4

% git clone https://github.com/siroyuri/food_manage  
% cd food_manage  
% bundle install  
% yarn install  
% rails db:create  
% rails db:migrate  
% rails s
