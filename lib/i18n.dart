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
    },
    'ja_JP': {
      'hello': 'こんにちは, @name',
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
      
    }
  };
}
