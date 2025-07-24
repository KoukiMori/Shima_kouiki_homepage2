import 'package:flutter/material.dart';

class ContentsText extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final double textSize;
  final FontWeight textWeight;
  final List<Widget>? subMenu;
  final bool showArrow;
  final bool isSelected; // 新しいプロパティ

  const ContentsText({
    super.key,
    required this.title,
    required this.onTap,
    this.textSize = 12,
    this.textWeight = FontWeight.w500,
    this.subMenu,
    this.showArrow = true,
    this.isSelected = false, // デフォルトはfalse
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
    final bool _isHighlighted = _isHover || _isExpanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // メインメニューアイテム
        GestureDetector(
          onTap: () {
            // クリックでサブメニューの開閉を切り替える
            if (widget.subMenu != null) {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
            widget.onTap(); // 親のonTap（MenuType変更）を呼び出す
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHover = true),
            onExit: (_) {
              setState(() => _isHover = false);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: _isHighlighted // ホバーまたはクリックでハイライト
                    ? const Color.fromARGB(255, 80, 105, 246)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: _isHover ? 18 : 14, // ホバーでサイズ変化
                      fontWeight:
                          _isHighlighted ? FontWeight.bold : FontWeight.w800,
                      color: _isHighlighted ? Colors.white : Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  if (widget.showArrow && widget.subMenu != null)
                    AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0, // 展開状態に応じて回転
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.arrow_right,
                        color: _isHighlighted ? Colors.white : Colors.black,
                        size: 30,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),

        // サブメニュー（展開時のみ表示）
        if (widget.subMenu != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 300), // ゆっくり展開
            curve: Curves.easeOut,
            child: _isExpanded // 展開状態に応じて表示
                ? Container(
                    margin: const EdgeInsets.only(left: 16, top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white, // サブメニュー背景色
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // 高さを最小限に
                      children: widget.subMenu!.map((subItem) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child:
                              subItem, // subItem自体がContentsTextであるため、内部でホバー効果を持つ
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
      ],
    );
  }
}
