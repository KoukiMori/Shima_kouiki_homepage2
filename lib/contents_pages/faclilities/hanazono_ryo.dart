import 'package:flutter/material.dart'; // ContentsTextをインポート
import 'package:shime_kouiki_homepage/content_text.dart';
import 'package:shime_kouiki_homepage/contents_munu.dart';
import 'package:shime_kouiki_homepage/top_page.dart'; // MenuTypeをインポートするため
import 'package:shime_kouiki_homepage/address_unit.dart'; // AddressUnitをインポート
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート
// import 'dart:math' as math; // 必要なら後で追加

class HanazonoRyo extends StatefulWidget {
  final Function(MenuType) onMenuSelected;

  const HanazonoRyo({
    super.key,
    required this.onMenuSelected,
  });

  @override
  State<HanazonoRyo> createState() => _HanazonoRyoState();
}

class _HanazonoRyoState extends State<HanazonoRyo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーを初期化
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    // アニメーション開始
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedMenuItem({
    required int index,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(
            0,
            50 * (1 - _controller.value), // 下から上へスライド
          ),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity, // 全体の幅を調整
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // 全体を中央寄せ
          children: [
            ContentsMumu(
              onMenuSelected: (menuType) {
                widget.onMenuSelected(menuType); // 親ウィジェットのonMenuSelectedを呼び出す
              },
            ),
            Center(
              child: Text(
                '花園寮',
                style: TextStyle(color: MainColors.textColor),
              ),
            ),
            const AddressUnit(),
          ],
        ),
      ),
    );
  }
}
