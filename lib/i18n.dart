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
          'longnickname': 'Nickname'
        },
        'ja_JP': {
          'hello': 'こんにちは, @name',
          'konichiwa': 'こんにちは、',
          'myAccount': 'マイアカウント',
          'name': '氏名(全角)',
          'editName': 'お名前(全角)',
          'editAlphabetName': 'お名前(ローマ字)',
          'alphabetName': '氏名(ローマ字)',
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
          'tac': 'サービス利用規約',
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
          'userId': 'ログインID',
          'password': 'パスワード',
          'contact': '連携先',
          'searchInput': '氏名、ユーザーID、ニックネーム',
          'userNotFound': 'ユーザーが見つかりませんでした。',
          'searchById': 'UserIDで検索',
          'shareData': 'データ共有',
          'sentRequest': 'リクエスト送信',
          'username': 'ユーザーID',
          'nickname': '氏名',
          'longnickname': 'ニックネーム',
          'viewData': 'データビュー',
          'viewSettings': '共有設定',
          'contact_address': "連絡先"
        }
      };
}
