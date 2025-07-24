import 'package:flutter/material.dart';

class ContentsText extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final double textSize;
  final FontWeight textWeight;
  final List<Widget>? subMenu;
  final bool showArrow;

  const ContentsText({
    super.key,
    required this.title,
    required this.onTap,
    this.textSize = 12,
    this.textWeight = FontWeight.w500,
    this.subMenu,
    this.showArrow = true,
  });

  @override
  State<ContentsText> createState() => _ContentsTextState();
}

class _ContentsTextState extends State<ContentsText> {
  bool _isHover = false;
  bool _isSubMenuHover = false;
  OverlayEntry? _overlayEntry;

  // メインメニューまたはサブメニューのどちらかがホバーされているかを判定
  bool get _shouldShowSubMenu => _isHover || _isSubMenuHover;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  // 親ウィジェットがRowかどうかを判定
  bool _isInRowLayout() {
    // コンテキストから親ウィジェットを確認
    // 簡易的な判定として、画面幅と要素数から推測
    final width = MediaQuery.of(context).size.width;
    return width >= 768; // デスクトップ幅の場合はRow（横並び）と判定
  }

  // オーバーレイ方式でサブメニューを表示（Row用）
  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: 200,
        child: Material(
          elevation: 4.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (widget.subMenu ?? [])
                .map((sub) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: sub,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRowLayout = _isInRowLayout();

    if (isRowLayout && widget.subMenu != null) {
      // Row（横並び）レイアウトの場合：オーバーレイ方式
      return GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isHover = true);
            if (_overlayEntry == null) {
              _overlayEntry = _createOverlayEntry();
              Overlay.of(context).insert(_overlayEntry!);
            }
          },
          onExit: (_) {
            setState(() => _isHover = false);
            _overlayEntry?.remove();
            _overlayEntry = null;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: _isHover
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
                    fontSize: 14,
                    fontWeight: _isHover ? FontWeight.bold : FontWeight.w400,
                    color: _isHover ? Colors.white : Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
                if (widget.showArrow && widget.subMenu != null)
                  Icon(
                    Icons.arrow_drop_down,
                    color: _isHover ? Colors.white : Colors.black,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Column（縦並び）レイアウトまたはサブメニューなしの場合：直接展開方式
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // メインメニューアイテム
          GestureDetector(
            onTap: widget.onTap,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHover = true),
              onExit: (_) => setState(() => _isHover = false),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: _isHover
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
                        fontSize: 14,
                        fontWeight:
                            _isHover ? FontWeight.bold : FontWeight.w400,
                        color: _isHover ? Colors.white : Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    if (widget.showArrow && widget.subMenu != null)
                      AnimatedRotation(
                        turns: _shouldShowSubMenu ? 0.25 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.arrow_right,
                          color: _isHover ? Colors.white : Colors.black,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // サブメニュー（Column用：展開時のみ表示）
          if (widget.subMenu != null && !isRowLayout)
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: _shouldShowSubMenu
                  ? MouseRegion(
                      onEnter: (_) => setState(() => _isSubMenuHover = true),
                      onExit: (_) => setState(() => _isSubMenuHover = false),
                      child: Container(
                        margin: const EdgeInsets.only(left: 16, top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          children: widget.subMenu!.map((subItem) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: subItem,
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
}
