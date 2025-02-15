import 'package:flutter/material.dart';

class PlayAndWinPage extends StatelessWidget {
  const PlayAndWinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select, Play and Win')),
      body: const Center(child: Text('Win rewards by playing!')),
    );
  }
}
