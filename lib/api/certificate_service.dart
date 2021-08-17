import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:secp256k1/secp256k1.dart';
import 'package:tuple/tuple.dart';

import 'package:pointycastle/api.dart' as POINTY;
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class CertificateInfo {
  String? username;
  String? timestamp;
  int? exp;

  CertificateInfo({this.username, this.timestamp, this.exp});

  CertificateInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    timestamp = json['timestamp'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['timestamp'] = this.timestamp;
    data['exp'] = this.exp;
    return data;
  }
}

String hashMessage(String message) {
  var bytes1 = utf8.encode(message);
  var digest1 = sha256.convert(bytes1);

  return digest1.toString();
}

String signMessage(privateKey, message) {
  var privateKeyHex = convertBase64ToHex(privateKey);
  var privateKeyDecode = PrivateKey.fromHex(privateKeyHex);
  var a = privateKeyDecode.signature(message);
  var base64Sign = convertHexToBase64(a.toRawHex());
  return base64Sign;
}

String? encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    return null;
  }
}

String? decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    Uint8List encryptedBytes =
        encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (s, e) {
    print("error: " + e.toString());
    return null;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    //  int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(currentHash + password + salt);
    else
      preHash = Uint8List.fromList(password + salt);

    currentHash = md5.convert(preHash).bytes as Uint8List;
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBtyes = concatenatedHashes.sublist(0, 32);
  var ivBtyes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i = 0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax) + 1;
  }
  return uint8list;
}

String convertBase64ToHex(String key) {
  var keyBase64Decode = base64.decode(key);
  var keyHexEncode = hex.encode(keyBase64Decode);

  return keyHexEncode;
}

String convertHexToBase64(String key) {
  var keyHexDecode = hex.decode(key);
  var keyBase64Encode = base64.encode(keyHexDecode);

  return keyBase64Encode;
}

Uint8List _seed() {
  var random = Random.secure();
  var seed = List<int>.generate(32, (_) => random.nextInt(255));
  return Uint8List.fromList(seed);
}

POINTY.PrivateKey _secp256k1KeyPair() {
  var keyParams = ECKeyGeneratorParameters(ECCurve_secp256k1());
  var random = FortunaRandom();
  random.seed(POINTY.KeyParameter(_seed()));
  var generator = ECKeyGenerator();
  generator.init(POINTY.ParametersWithRandom(keyParams, random));
  return generator.generateKeyPair().privateKey;
}

Map<String, dynamic> generateKeyPairAndEncrypt(String password) {
  ECPrivateKey privateKey = _secp256k1KeyPair() as ECPrivateKey;
  var d = privateKey.d;
  final privateKeyDecode = PrivateKey(d as BigInt);
  String publicKeyBase64 =
      convertHexToBase64(privateKeyDecode.publicKey.toCompressedHex());
  String privateKeyBase64 = convertHexToBase64(privateKeyDecode.toHex());
  var encryptedPrivateKey = encryptAESCryptoJS(privateKeyBase64, password);
  final Map<String, dynamic> encryptedKeyPair = {
    "publicKey": publicKeyBase64,
    "encryptedPrivateKey": encryptedPrivateKey
  };
  return encryptedKeyPair;
}
