import 'package:flutter/material.dart';

class Football extends StatelessWidget {
  const Football({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://i.imgur.com/qc1c4un.png',
    );
  }
}