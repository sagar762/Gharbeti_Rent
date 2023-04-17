import 'package:flutter/material.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Bill Screen',
      ),
    );
  }
}
