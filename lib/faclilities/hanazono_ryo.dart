import 'package:flutter/material.dart'; // ContentsTextをインポート
import 'package:shime_kouiki_homepage/contents_munu.dart';
import 'package:shime_kouiki_homepage/top_page.dart'; // MenuTypeをインポートするため
import 'package:shime_kouiki_homepage/address_unit.dart'; // AddressUnitをインポート
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
              child: Text('花園寮'),
            ),
            const AddressUnit(),
          ],
        ),
      ),
    );
  }
}
