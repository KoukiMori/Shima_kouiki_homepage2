import 'package:flutter/material.dart';
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート

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
    required String assetsName,
  });

  @override
  State<ContentsText> createState() => _ContentsTextState();
}

class _ContentsTextState extends State<ContentsText> {
  bool _isHover = false;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  // サブメニューを表示するオーバーレイを作成
  OverlayEntry _createOverlayEntry() {
    // RenderBoxを使ってウィジェットの位置とサイズを取得
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx, // 親ウィジェットと同じX座標
        top: offset.dy + size.height, // 親ウィジェットのすぐ下
        width: 200, // サブメニューの幅を固定
        child: AnimatedSize(
          // AnimatedSizeを再導入
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
          child: AnimatedOpacity(
            // AnimatedOpacityを再導入
            opacity: _isHover ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 100),
            curve: Curves.ease,
            child: Container(
              // Materialの代わりにContainerを使用
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 235, 243), // サブメニューの背景色
                boxShadow: [
                  // 影を再現
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 21),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // コンテンツに合わせて高さを調整
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.subMenu ?? [])
                    .map((sub) => Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, bottom: 6),
                          child: sub,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetectorをMouseRegionの外に移動
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHover = true);
          if (widget.subMenu != null) {
            _overlayEntry = _createOverlayEntry();
            Overlay.of(context).insert(_overlayEntry!);
          }
        },
        onExit: (_) {
          setState(() => _isHover = false);
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 450),
          curve: Curves.ease,
          padding: EdgeInsets.symmetric(
            vertical: _isHover ? 10 : 4,
            horizontal: _isHover ? 8 : 0,
          ),
          decoration: BoxDecoration(
              color: _isHover
                  ? const Color.fromARGB(255, 80, 105, 246)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: _isHover ? 16 : 14,
                  fontWeight: _isHover ? FontWeight.bold : FontWeight.w400,
                  color: _isHover ? Colors.white : MainColors.textColor,
                  decoration: TextDecoration.none,
                ),
                child: Text(widget.title),
              ),
              if (widget.showArrow)
                AnimatedRotation(
                  turns: _isHover ? 0.25 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.arrow_right,
                    color: _isHover ? Colors.white : MainColors.textColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  final String title;
  final Color color;
  final double textSize;
  final FontWeight textWeight;
  const TextContent({
    super.key,
    required this.title,
    this.textSize = 12,
    this.color = const Color(0xff666666), // MainColors.textColorと同じ値を定数として設定
    this.textWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 200),
      style: TextStyle(
        fontSize: textSize,
        fontWeight: textWeight,
        color: color,
        decoration: TextDecoration.none,
      ),
      child: Text(title),
    );
  }
}

class SubMenuText extends StatefulWidget {
  final String title;
  const SubMenuText({super.key, required this.title});

  @override
  State<SubMenuText> createState() => _SubMenuTextState();
}

class _SubMenuTextState extends State<SubMenuText> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: Text(
        widget.title,
        style: TextStyle(
          color: _isHover
              ? const Color.fromARGB(255, 80, 105, 246)
              : MainColors.textColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
