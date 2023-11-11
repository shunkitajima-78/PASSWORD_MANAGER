#!/bin/bash

echo "パスワードマネージャーへようこそ！"

echo "サービス名を入力してください："
read service_name

if grep -q "^$service_name:" passwords.txt; then
	    echo "このサービス名はすでに使用されています。上書きしますか? (y/n)"
	    read update_choice

	    if [ "$update_choice" != "y" ]; then
	    　　　　　　　　　　　　　echo "サービス名を再設定してください"　　　　　
           　　　　　　　　　　　　　 exit 1
        　　　　　　　　fi
fi
