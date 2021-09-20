import 'package:flutter/material.dart';

class TestQRScreen extends StatelessWidget {
  final String qr;
  TestQRScreen({required this.qr});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(qr),
      ),
    );
  }
}
