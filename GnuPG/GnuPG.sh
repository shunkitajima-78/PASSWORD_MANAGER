#!/bin/bash

while true; do
     echo "パスワードマネージャーへようこそ！"
     echo "終了したい場合は Exit と入力してください。"

     echo "あなたのGPGキーで設定したメールアドレスを入力してください。"
     
     # ユーザーからの入力を受け取り、gpg_email変数に代入する
     read gpg_email

     # 「?」演算子: 変数が設定されていない場合にエラーメッセージを表示
     gpg_email="${gpg_email:?GPGのメールアドレスを設定してください。}"
     
     echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
     read choice

     case $choice in
	"Add Password")
	    read -p "サービス名を入力してください: " serviceName
	    serviceName="${serviceName:?サービス名を設定してください。}"

	    read -p "ユーザー名を入力してください: " userName
	    userName="${userName:?ユーザー名を設定してください。}"

	    read -s -p "パスワードを入力してください: " password
	    password="${password:?パスワードを設定してください。}"

	    # 復号化したデータを一時ファイルに保存し、エラーは出力しない
	    gpg -d password.gpg > password.txt 2> /dev/null
	    echo "$serviceName:$userName:$password" >> password.txt

	    # 入力ファイルを暗号化して出力ファイルに保存する
	    gpg -r "$gpg_email" -e -o password.gpg password.txt

	    echo "パスワードの追加は成功しました。"
	    ;;

        "Get Password")
            read -p "サービス名を入力してください: " serviceName
	    # 復号化したデータを一時ファイルに保存し、エラーは出力しない
	    gpg -d password.gpg > password.txt 2> /dev/null

	    # serviceNameに対応するpassをpassword.txtファイルから取得
	    password=$(grep "^$serviceName:" password.txt | cut -d: -f3)

	    if [ -z "$password" ]; then
	        echo "そのサービスは登録されていません。"
	     
	    else
	        echo "サービス名：$serviceName"
		
                # サービス名に対応するユーザー名を表示
		echo "ユーザー名：$(grep "^$serviceName:" password.txt | cut -d: -f2)"
		
                # サービス名に対応するパスワードを表示
		echo "パスワード：$password"

	    fi
	    ;;

        "Exit")
	    echo "Thank you!"
	    exit
	    ;;

	*)
            echo "入力が間違えています。Add Password/Get Password/Exitから入力してください。"
	    ;;

     esac
done

     gpg -r password.txt

