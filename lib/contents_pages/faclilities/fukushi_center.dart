import 'package:flutter/material.dart'; // ContentsTextをインポート
import 'package:shime_kouiki_homepage/contents_munu.dart';
import 'package:shime_kouiki_homepage/top_page.dart'; // MenuTypeをインポートするため
import 'package:shime_kouiki_homepage/address_unit.dart'; // AddressUnitをインポート
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート
// import 'dart:math' as math; // 必要なら後で追加

class FukushiCenter extends StatefulWidget {
  final Function(MenuType) onMenuSelected;

  const FukushiCenter({
    super.key,
    required this.onMenuSelected,
  });

  @override
  State<FukushiCenter> createState() => _FukushiCenterState();
}

class _FukushiCenterState extends State<FukushiCenter>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
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
                '福祉センター',
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
