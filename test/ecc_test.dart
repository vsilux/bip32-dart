import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:test/test.dart';
import 'package:bip32/src/utils/ecurve.dart' as ecc;
import 'package:bip32/bip32.dart' as bip32;

final defichain_testnet = bip32.NetworkType(bip32: bip32.Bip32Type(private: 0x04358394, public: 0x043587cf), wif: 0xef);

void main() {
  group("curve test", () {
    test("test private key generation", () {
      // seed
      //55b18e96ce3964ef2c81ad69249eca6d42682c11fbe525df6671fcbf0c2be902 private key

      final hdSeed = bip32.BIP32.fromSeed(
          Uint8List.fromList(HEX.decode("6607599b768ce88470b3b20919f9c63bff663e2f1ec3e3072d22fd9da3847784c361d5accc3b411019f5c81dd3e4ccf9fd1fddb232bfc9bfe23864e2e6ee793f")), defichain_testnet);

      final xMasterPriv = bip32.BIP32.fromSeed(hdSeed.privateKey!, defichain_testnet);
      final privateKey = xMasterPriv.derivePath("m/0'/0'/0'");

      final privateKeyHex = HEX.encode(privateKey.privateKey!);

      expect("55b18e96ce3964ef2c81ad69249eca6d42682c11fbe525df6671fcbf0c2be902", privateKeyHex);
    });

    test("test sign", () {
      ecc.sign(Uint8List.fromList(HEX.decode("b11d3d5e4ae12b89d5e3872ccc7d1f96d29b0ab888b67dccf1be5164b811cdbe")), Uint8List.fromList(HEX.decode("55b18e96ce3964ef2c81ad69249eca6d42682c11fbe525df6671fcbf0c2be902")));
    });
  });

  group('Failing ecc test', () {
    test('Should fail with the third set of key-msg', () {
      var key, msg, sig;

      key = 'f92ca9fe5f77afa489214a7ba2bd6b36d30dd4acdb55c70d1378b5c45c831820';
      msg = '045a7448dffff67c08023d16279c57c0bd16af6467580c183cc4672e768b8a77';

      sig = ecc.sign(Uint8List.fromList(HEX.decode(msg)), Uint8List.fromList(HEX.decode(key)));
      print(HEX.encode(sig));

      key = '8c39fb3d889b6be22850254dc7ce3247c559d9f968785d88251ee4457633e335';
      msg = '6ad99bc30926fd79cf5a977044088fd298a59728c5b0c1040713d3a8e1c1e69b';

      sig = ecc.sign(Uint8List.fromList(HEX.decode(msg)), Uint8List.fromList(HEX.decode(key)));
      print(HEX.encode(sig));

      key = '2de619ea940d31927e0a7bbd5ebf855ab66f488b94a65cf929a1eb70b54ec771';
      msg = 'd82a6db2583353856dd4dadc38cdb6373b092ea1f026fa04f03aa3c4e972454f';

      sig = ecc.sign(Uint8List.fromList(HEX.decode(msg)), Uint8List.fromList(HEX.decode(key)));
      print(HEX.encode(sig));
    });
  });
}
