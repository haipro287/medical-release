import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World, @name',
          'myAccount': 'My Account',
          'name': 'Name',
          'alphabetName': 'Name (alphabet)',
          'dob': 'DOB',
          'email': 'Email',
          'phoneNumber': 'Phone Number',
          'citizenCode': 'Citizen Code',
          'edit': 'Edit',
          'cancel': 'Cancel',
          'save': 'Save',
          'login': 'Sign in',
          'forgotPassword': 'Forgot Password',
          'signup': 'Sign up',
          'signupButton': 'Sign up',
          'userId': 'User ID',
          'password': 'Password',
          'contact': 'Contact',
          'searchInput': 'Type Name, ID or nickname',
          'userNotFound': 'User not found',
          'searchById': 'Search by UserID',
          'shareData': 'Share data',
          'sentRequest': 'Sent request',
          'username': 'Username',
          'nickname': 'Nickname',
          'longnickname': 'Nickname',
          "next": "Next",
          "wrongPass": "Wrong username or password",
          "confirmSentData": "Confirm Share Data",
          "userReceived": "User received",
          "data": "Data",
          "timeSharing": "Time Sharing",
          "sentData": "Sent data",
          "shareListScreenTitle": "Share Data",
          "chooseUserToShare": "Please choose a user to share data",
          "shareListServiceTitle": "Services List",
          "chooseServiceToShare": "Choose services you want to share",
          "timeSharingTitle": "Time sharing",
          "chooseTimeSharing": "How long you want to share ?",
          "searchUserTitle": "Find User",
        },
        'ja_JP': {
          'hello': 'こんにちは, @name',
          'konichiwa': 'こんにちは、',
          'myAccount': 'マイアカウント',
          'name': '氏名（漢字)',
          'editName': '氏名（漢字)',
          'editAlphabetName': '氏名（カタカナ)',
          'alphabetName': '氏名（カタカナ)',
          'dob': '生年月日',
          'email': 'メールアドレス',
          'phoneNumber': '電話番号',
          'citizenCode': '住民番号',
          'edit': '修正',
          'home': 'ホーム',
          'share': '共有',
          'view': 'ビュー',
          'user': 'アカウント',
          'my_account': 'マイアカウント',
          'my_qr': 'マイQRコード',
          'change_password': "パスワード変更",
          "change_password_btn": "変更",
          'tac': 'サービス利用規約とプライバシーポリシー',
          'log_out': 'ログアウト',
          'scan_qr': "QRコードスキャン",
          'my_qr_guide': '友達があなたのQRコードをスキャンするとあなたを見つけることができます。',
          'scan_qr_guide': 'QRコードをスキャンして友達を追加します。',
          'cancel': 'キャンセル',
          'save': '保存',
          'connectService': 'サービス連携',
          'login': 'ログイン',
          'forgotPassword': 'パスワードをお忘れですか。',
          'signup': '新規アカウント作成',
          'signupButton': '登録',
          'userId': 'ユーザーID',
          'password': 'パスワード',
          'contact': '連携先',
          'searchInput': '氏名、ユーザーID、ニックネーム',
          'userNotFound': 'ユーザーが見つかりませんでした。',
          'searchById': 'ユーザーIDで検索',
          'shareData': 'データ共有',
          'sentRequest': 'リクエスト送信',
          'sentRequestBtn': '送信',
          'username': 'ユーザーID',
          'nickname': '氏名',
          'longnickname': 'ニックネーム',
          'viewDataRequest': 'データビュー',
          'viewDataShare': '共有設定',
          'contact_address': "連絡先",
          "next": "次へ",
          "wrongPass": "ログインID又はパスワードが一致しません。",
          "serviceList": "サービス一覧",
          "serviceListSearch": "検索結果@total件見つかりました",
          "confirmSentData": "データ共有確認",
          "data": "データ",
          "timeSharing": "共有開始日時",
          "timeRequest": "リクエスト送信日時",
          "timeStop": "共有中止日時",
          "sentDataBtn": "共有",
          "shareListScreenTitle": "データ共有先選択",
          "chooseUserToSent": "共有先を選択してください。",
          "chooseUserToRequest": "送信先を選択してください。",
          "shareListServiceTitle": "共有データ選択",
          "chooseServiceToShare": "連携したいサービスを選択してください。",
          "timeSharingTitle": "共有期限選択",
          "chooseTimeSharing": "データ参考権限は有効ある期限を選択してください。",
          "searchUserTitle": "ユーザー検索",
          "sendRequestScreenTitle": "リクエスト送信先選択",
          "sentRequestServiceTitle": "リクエストデータ",
          "timeSentRequestTitle": "共有期限",
          "confirmSentRequest": "リクエスト確認",
          "chooseServiceToSentRequest": "貰いたいデータを選択してください。",
          "pending_color": "検討中",
          "sharing_color": "共有中",
          "expired_color": "共有中止 ",
          "rejected_color": "拒否",
          "expired_reqModeBtn": "リクエスト送信",
          "sharing_reqModeBtn": "ビュー",
          "rejected_reqModeBtn": "リクエスト再送信",
          "pending_reqModeBtn": "リクエスト再送信",
          "accept": "承認",
          "edit_data_to_share": "共有設定編集",
          "stop_sharing": "共有中止",
          "detail_sharing": "共有詳細",
          "detail_request": "リクエスト詳細",
          "data_reference": "データ参照",
          "data_request": "データリクエスト",
          "confirmPassword": "新パスワード確認入力",
          "dataReceiver": "送信先",
          "dataSender": "共有元",
          "requestReceived": "送信先",
          "requestSender": "送信元",
          "oldPassword": "現パスワード",
          "newPassword": "新パスワード",
          "confirmNewPassword": "新パスワード確認入力",
          "passwordChangeSuccessfully": "パスワードが変更されました。",
          "confirmSignup": "アカウント確認",
          "confirmEmailMessage": "様宛、送信された6桁のユーザー確認コードを入力して下さい。",
          "emailResend": "Eメール再送信",
          "emailResendParam": "Eメール再送信（@time秒）",
          "emailCodeNotMatch": "確認コードが不正です。",
          "confirm": "確認",
          "accountConfirm": "アカウント確認済み",
          "accountConfirmMessage": "次回からユーザーID、メールアドレス でログインできます。",
          'alert_logout': "ログアウトしてもよろしいでしょうか。",
          'logout_cancel': "キャンセル",
          'logout_confirm': 'ログアウト',
          'privacy_guide': '他人が自分を検索できないように設定',
          'sharing_history_page': "ユーザーID、氏名、ニックネームで検索",
          'so': "で",
          "records_result": "結果は出ました。",
          "terms_of_use": "サービス利用規約",
          "stop": "共有中止",
          "banned_user_msg": "あなたのアカウントは停止されました。下記の連絡先にお問い合わせ下さい。09012345678",
          "resetPassword": "パスワード再設定",
          "resetPasswordMess1":
              "パスワード再設定のために、ユーザー登録時に登録したメールアドレスを入力し、送信ボタンを押して下さい。",
          "resetPasswordMess2": "入力したメールアドレスに、パスワード再設定用のユーザー確認コードを送信します。",
          "resetEmailInvalid": "メールアドレスは不正な値です。",
          "resetEmailNotExist": "メールアドレスは存在していません。",
          "resetPasswordOTP1": "にパスワード再設定用のユーザー確認コードを送信しました。",
          "resetPasswordOTP2": "以下に、パスワード再設定用のユーザー確認コードを入力し、次へボタンをクリックしてください。",
          "emptyRecords": "記録はありません。",
          "confirmEmail": "メール確認",
          "check_internet_connection1": "インターネット接続を",
          "check_internet_connection2": "チェックしてください。",
          "scanQR": "QRコード",
          "status_account": "状態",
          "unActive": "非アクティブ",
          "email_alert":
              "登録されたメールアドレスに確認コー ドを送信しました。送信されたコードを利用して、 登録作業を継続して下さい",
          "back": "戻る",
          "count_contact": "@count結果は見つかりました。"
        }
      };
}
