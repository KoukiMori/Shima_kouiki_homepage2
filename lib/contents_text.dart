import 'package:flutter/material.dart';
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート

class ContentsText extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final double textSize;
  final FontWeight textWeight;
  final List<Widget>? subMenu;
  final bool showArrow;
  final bool isSelected; // 新しいプロパティ
  final String assetsName;

  const ContentsText({
    super.key,
    required this.title,
    required this.onTap,
    this.textSize = 12,
    this.textWeight = FontWeight.w500,
    this.subMenu,
    this.showArrow = true,
    this.isSelected = false,
    this.assetsName = '',
  });

  @override
  State<ContentsText> createState() => _ContentsTextState();
}

class _ContentsTextState extends State<ContentsText> {
  bool _isHover = false; // メインメニュー項目にホバーしているか
  bool _isExpanded = false; // メニューが展開されているか（クリックで制御）

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isSelected; // 初期選択状態を反映
  }

  @override
  void didUpdateWidget(covariant ContentsText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      _isExpanded = widget.isSelected; // 親からの選択状態の変更を反映
    }
  }

  @override
  Widget build(BuildContext context) {
    // ホバーまたは展開（クリック）でハイライト
    final bool isHighlighted = _isHover || _isExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // メインメニューアイテム
        AnimatedContainer(
          duration: const Duration(milliseconds: 300), // アニメーション時間を延長
          curve: Curves.easeInOut, // 滑らかなカーブ
          transform: Matrix4.identity()
            ..scale(_isHover ? 1.05 : 1.0), // ホバー時に軽く拡大

          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHover = true);
            },
            onExit: (_) {
              setState(() => _isHover = false);
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                widget.onTap();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: Image.asset(
                        widget.assetsName,
                        width: 180,
                        height: 180,
                        fit: BoxFit.cover,
                        scale: 1,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: _isHover ? 18 : 14, // ホバーでサイズ変化
                              fontWeight: isHighlighted
                                  ? FontWeight.bold
                                  : FontWeight.w800,
                              color: const Color.fromARGB(255, 14, 85, 249),
                              decoration: TextDecoration.none,
                            ),
                            child: Text(widget.title),
                          ),
                          if (widget.showArrow && widget.subMenu != null)
                            AnimatedRotation(
                              turns: _isExpanded ? 0.25 : 0, // 展開状態に応じて回転
                              duration: const Duration(milliseconds: 300),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(2),
                                child: Icon(
                                  Icons.arrow_right,
                                  color: const Color.fromARGB(255, 14, 85, 249),
                                  size: _isHover ? 32 : 30,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // サブメニュー（展開時のみ表示）
        if (widget.subMenu != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 400), // ゆっくり展開
            curve: Curves.easeOutCubic,
            child: _isExpanded // 展開状態に応じて表示
                ? AnimatedOpacity(
                    opacity: _isExpanded ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.only(left: 16, top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: MainColors.primaryColor.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: MainColors.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: widget.subMenu!.asMap().entries.map((entry) {
                          int index = entry.key;
                          Widget subItem = entry.value;

                          return TweenAnimationBuilder(
                            duration: Duration(
                                milliseconds: 300 + (index * 100)), // スタガード効果
                            tween: Tween<double>(begin: 0.0, end: 1.0),
                            builder: (context, double value, child) {
                              return Transform.translate(
                                offset:
                                    Offset(0, 20 * (1 - value)), // 下から上にスライド
                                child: Opacity(
                                  opacity: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.transparent,
                                      ),
                                      child: subItem,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }
}
