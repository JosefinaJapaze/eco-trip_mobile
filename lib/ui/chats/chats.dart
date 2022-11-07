import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: "chats_title"),
      body: Container(),
    );
  }
}
