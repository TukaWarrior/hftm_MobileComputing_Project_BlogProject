import 'package:flutter/material.dart';

class EditorView extends StatelessWidget {
  const EditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Editor'),
      ),
      body: const Center(
        child: Text('Editor will be implemented here'),
      ),
    );
  }
}
