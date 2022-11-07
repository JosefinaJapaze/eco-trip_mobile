import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: "my_wallet_title"),
      body: Container(),
    );
  }
}
