import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// テキストを順次フェードイン・スライドインするアニメーションウィジェット
class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration delay;
  final TextAlign textAlign;

  const AnimatedTextWidget({
    super.key,
    required this.text,
    required this.style,
    this.delay = Duration.zero,
    this.textAlign = TextAlign.center,
  });

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーを初期化（1.5秒間のアニメーション）
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // フェードインアニメーション
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // スライドインアニメーション（下から上へ）
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5), // 下から開始
      end: Offset.zero, // 最終位置
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // 指定された遅延後にアニメーション開始
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Text(
              widget.text,
              style: widget.style,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }
}
