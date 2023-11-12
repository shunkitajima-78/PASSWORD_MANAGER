#!/bin/bash

while true; do
	echo "パスワードマネージャーへようこそ！"
	echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
	read choice

	case $choice in
	     # Add Password が入力された場合
	　　　　　　　　　　"Add Password")

		read -p "サービス名を入力してください: " serviceName
		read -p "ユーザー名を入力してください: " userName
		read -s -p "パスワードを入力してください: " password

		echo "$serviceName:$userName:$password" >> passwords.txt
		echo "パスワードの追加は成功しました。"
		;;
             
	     # Get Password が入力された場合
	     "Get Password")

		read -p "サービス名を入力してください: " serviceName
		password=$(grep "^$serviceName:" passwords.txt | cut -d: -f3)
                
		## サービス名が保存されていなかった場合
		if [ -z "$password" ]; then
		   echo "そのサービスは登録されていません。"
                
		## サービス名が保存されていた場合
	        else 
		   echo "サービス名：$serviceName"
		   echo "ユーザー名：$(grep "^$serviceName:" passwords.txt | cut -d: -f2)"
		   # サービス名に対応するパスワードを表示
		   echo "パスワード：$password"
		fi
		;;

　　　　　　　　　　　　　　　　　　　　　　　　　　　# Exit が入力された場合
	     "Exit")
                echo "Thank you!"
		## プログラムが終了
		exit
		;;

	　　　　　　　　　　# Add Password/Get Password/Exit 以外が入力された場合
	     *)
	        echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
		;;

	esac
done
