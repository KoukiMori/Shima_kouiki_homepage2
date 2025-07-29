import 'package:flutter/material.dart';
import 'package:shime_kouiki_homepage/contents_pages/faclilities/hanazono_ryo.dart';
import 'package:shime_kouiki_homepage/contents_pages/faclilities/job_page.dart';
import 'package:shime_kouiki_homepage/contents_pages/faclilities/sainiwa_ryo.dart';
import 'package:shime_kouiki_homepage/contents_pages/faclilities/tomoyama_en.dart';
import 'contents_pages/top_page_content/top_page_contents.dart';
import 'package:google_fonts/google_fonts.dart'; // GoogleFontsを追加
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート

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
  jobPage, // JobPageを追加
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
        Positioned(
          right: 0,
          top: 0,
          child: JobTab(
            onTap: () {
              setState(() {
                selectedMenu = MenuType.jobPage;
                JobPage(
                  onMenuSelected: (_) {
                    setState(() {
                      selectedMenu = MenuType.jobPage;
                    });
                  },
                );
              });
            },
          ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 志摩広域行政組合と読み仮名をタップでトップページに移動
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMenu = MenuType.home;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        '志摩広域行政組合',
                        style: GoogleFonts.notoSansJavanese(
                          fontSize: 32,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w100,
                          color: MainColors.textColor,
                        ),
                      ),
                      Text(
                        'しまこういきぎょうせいくみあい',
                        style: GoogleFonts.notoSansJavanese(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w100,
                          color: MainColors.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  color: Colors.white,
                  child: _buildDownContent(),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // タブレット・スマホ用は簡略化（必要であれば後で詳細化）
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'モバイルレイアウト',
              style: TextStyle(fontSize: 24, color: MainColors.textColor),
            ),
            // 必要に応じてモバイル用メニューやコンテンツを追加
          ],
        ),
      );
    }
    return content;
  }

  // メインコンテンツを選択状態で切り替え
  Widget _buildDownContent() {
    switch (selectedMenu) {
      case MenuType.home:
        return TopPageContents(
          onMenuSelected: (menuType) {
            setState(() {
              selectedMenu = menuType;
            });
          },
        );
      case MenuType.sainiwaryo:
        return SainiwaRyo(
          onMenuSelected: (menuType) {
            setState(() {
              selectedMenu = menuType;
            });
          },
        );
      case MenuType.tomoyamaen:
        return TomoyamaEn(
          onMenuSelected: (menuType) {
            setState(() {
              selectedMenu = menuType;
            });
          },
        );
      case MenuType.hanazonoryo:
        return HanazonoRyo(
          onMenuSelected: (menuType) {
            setState(() {
              selectedMenu = menuType;
            });
          },
        );
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
      case MenuType.jobPage:
        return JobPage(
          onMenuSelected: (menuType) {
            setState(() {
              selectedMenu = menuType;
            });
          },
        ); // JobPageを表示
      default:
        return const SizedBox.shrink();
    }
  }
}

class JobTab extends StatelessWidget {
  final VoidCallback onTap;

  JobTab({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 12, 20, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
            ),
            color: MainColors.primaryColor,
          ),
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
