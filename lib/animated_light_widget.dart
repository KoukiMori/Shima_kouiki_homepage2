import 'package:flutter/material.dart';
import 'dart:math' as math;

/// light画像を下から上に降りてくるアニメーションで表示するウィジェット
class AnimatedLightWidget extends StatefulWidget {
  final String imagePath;
  final Duration delay;
  final double size;

  const AnimatedLightWidget({
    super.key,
    required this.imagePath,
    this.delay = Duration.zero,
    this.size = 100.0,
  });

  @override
  State<AnimatedLightWidget> createState() => _AnimatedLightWidgetState();
}

class _AnimatedLightWidgetState extends State<AnimatedLightWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーを初期化（2秒間のアニメーション）
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 位置のアニメーション（下から上へ）
    _positionAnimation = Tween<double>(
      begin: 200.0, // より大きな移動距離
      end: 0.0, // 最終位置
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart, // 滑らかな減速カーブ
    ));

    // 透明度のアニメーション
    _opacityAnimation = Tween<double>(
      begin: 0.0, // 透明から開始
      end: 1.0, // 完全に表示
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // 指定された遅延後にアニメーション開始
    Future.delayed(widget.delay, () {
      if (mounted) {
        print('Starting animation for ${widget.imagePath}'); // デバッグログ
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
        return Transform.translate(
          offset: Offset(0, _positionAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.3), // テスト用背景色
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                widget.imagePath,
                width: widget.size,
                height: widget.size,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  print(
                      'Error loading image: ${widget.imagePath} - $error'); // エラーログ追加
                  return Container(
                    width: widget.size,
                    height: widget.size,
                    color: Colors.red.shade300,
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
