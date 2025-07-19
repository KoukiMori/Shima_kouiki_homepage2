import 'package:flutter/material.dart';

class TopPageContents extends StatelessWidget {
  const TopPageContents({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ここがトップページのメインコンテンツです',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
