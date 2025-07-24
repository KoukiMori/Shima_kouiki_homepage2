import 'package:flutter/material.dart';
import 'top_page_contents.dart';
import 'package:google_fonts/google_fonts.dart'; // GoogleFontsを追加

// メニュー種別をenumで管理
enum MenuType {
  home,
  sainiwaryo,
  tomoyamaen,
  hanazonoryo,
  fukushicenter,
  nyushononagare,
  kumiai,
  reikishu,
  nyusatsu,
  sonota,
  // 住所連絡先はnullで管理
}

class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  MenuType? selectedMenu = MenuType.home; // 初期はトップページ

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        _buildMainContent(width),
        const Positioned(
          right: 0,
          top: 0,
          child: JobTab(),
        ),
      ],
    );
  }

  Widget _buildMainContent(double width) {
    Widget content;
    if (width >= 768) {
      final double containerWidth = width > 1200 ? 1200 : width;
      content = SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            width: containerWidth * .8,
            // color: Colors.orange,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '志摩広域行政組合',
                      style: GoogleFonts.notoSansJavanese(
                        // M PLUS 1pフォントを適用 (キャメルケースで修正)
                        fontSize: 32,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      'しまこういきぎょうせいくみあい',
                      style: GoogleFonts.notoSansJavanese(
                        // M PLUS 1pフォントを適用 (キャメルケースで修正)
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: _buildRightContent(),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (width > 480) {
      // タブレット用（省略）
      content = Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .02),
            color: Colors.green,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    child: Container(
                      color: Colors.yellow,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // スマホ用（省略）
      content = Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * .02),
            color: Colors.green,
            child: Column(
              children: [
                Container(
                  height: 60,
                  color: Colors.grey,
                ),
                Container(
                  height: 120,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      );
    }
    return content;
  }

  // 右側のメインコンテンツを選択状態で切り替え
  Widget _buildRightContent() {
    switch (selectedMenu) {
      case MenuType.home:
        return TopPageContents(
          onMenuSelected: (nemuType) {
            setState(() {
              selectedMenu = nemuType;
            });
          },
        );
      case MenuType.sainiwaryo:
        return const Center(child: Text('才庭寮のコンテンツ'));
      case MenuType.tomoyamaen:
        return const Center(child: Text('ともやま苑のコンテンツ'));
      case MenuType.hanazonoryo:
        return const Center(child: Text('花園寮のコンテンツ'));
      case MenuType.fukushicenter:
        return const Center(child: Text('福祉センターのコンテンツ'));
      case MenuType.nyushononagare:
        return const Center(child: Text('入所の流れのコンテンツ'));
      case MenuType.kumiai:
        return const Center(child: Text('組合概要のコンテンツ'));
      case MenuType.reikishu:
        return const Center(child: Text('例規集のコンテンツ'));
      case MenuType.nyusatsu:
        return const Center(child: Text('入札情報のコンテンツ'));
      case MenuType.sonota:
        return const Center(child: Text('その他のコンテンツ'));
      default:
        // 住所連絡先や未選択時は何も表示しない
        return const SizedBox.shrink();
    }
  }
}

class JobTab extends StatelessWidget {
  const JobTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 12, 20, 16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
              ),
              color: Color.fromARGB(255, 80, 105, 246)),
          child: const Text(
            '求職者の方はこちら',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
