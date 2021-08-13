import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World, @name',
        },
        'ja_JP': {
          'hello': 'こんにちは, @name',
          'home': 'ホーム',
          'share': '共有',
          'view': 'ビュー',
          'user': 'アカウント',
          'my_account': 'マイアカウント',
          'my_qr': 'マイQRコード',
          'change_password': "パスワード変更",
          'tac': 'サービス利用規約',
          'log_out': 'ログアウト'
        }
      };
}
