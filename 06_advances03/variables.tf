# サーバ管理者のパスワード
variable password {
    # 以下任意の値を設定してください。
    # コメントアウトしたままの場合、terraform apply時に入力ダイアログが表示されます。
    # default = "YOUR_PASSWORD_HERE"
}

# VPCルータのPre Shared Secret
variable pre_shared_secret { 
    # 以下任意の値を設定してください。
    # コメントアウトしたままの場合、terraform apply時に入力ダイアログが表示されます。
    # default = "test12345" 
}

# VPCルータのリモートアクセスクライアント ユーザー名
variable vpn_username { 
    # 以下任意の値を設定してください。
    # コメントアウトしたままの場合、terraform apply時に入力ダイアログが表示されます。
    # default = "PutYourName" 
}

# VPCルータのリモートアクセスクライアント パスワード
variable vpn_password { 
    # 以下任意の値を設定してください。
    # コメントアウトしたままの場合、terraform apply時に入力ダイアログが表示されます。
    # default = "PutYourPassword" 
}
