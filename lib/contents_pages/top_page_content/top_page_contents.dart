import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shime_kouiki_homepage/contents_munu.dart';
import 'package:shime_kouiki_homepage/top_page.dart'; // MenuTypeをインポートするため
import 'package:shime_kouiki_homepage/contents_pages/top_page_content/topic.dart'; // Topicモデルをインポート
import 'package:shime_kouiki_homepage/address_unit.dart'; // AddressUnitをインポート
import 'package:shime_kouiki_homepage/colors.dart'; // MainColorsをインポート
import 'package:shime_kouiki_homepage/animated_text_widget.dart'; // アニメーションテキストウィジェット
// import 'dart:math' as math; // 必要なら後で追加

class TopPageContents extends StatefulWidget {
  final Function(MenuType) onMenuSelected;

  const TopPageContents({
    super.key,
    required this.onMenuSelected,
  });

  @override
  State<TopPageContents> createState() => _TopPageContentsState();
}

class _TopPageContentsState extends State<TopPageContents>
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
            // 1. メインテキスト部分
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60.0), // 上下の余白
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  Column(
                    children: [
                      AnimatedTextWidget(
                        text: '1977年',
                        style: GoogleFonts.notoSansJavanese(
                            fontSize: 80,
                            fontWeight: FontWeight.w300,
                            height: .6,
                            decoration: TextDecoration.none,
                            color: MainColors.textColor),
                        delay: const Duration(milliseconds: 200),
                      ),
                      AnimatedTextWidget(
                        text: '昭和52年',
                        style: GoogleFonts.notoSansJavanese(
                            fontSize: 16,
                            height: .9,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none,
                            color: MainColors.textColor),
                        delay: const Duration(milliseconds: 600),
                      ),
                    ],
                  ),
                  AnimatedTextWidget(
                    text: '志摩の介護',
                    style: GoogleFonts.notoSansJavanese(
                        fontSize: 41,
                        fontWeight: FontWeight.w300,
                        height: 1.8,
                        decoration: TextDecoration.none,
                        color: MainColors.textColor),
                    delay: const Duration(milliseconds: 1000),
                  ),
                  AnimatedTextWidget(
                    text: 'ここから始まりました。',
                    style: GoogleFonts.notoSansJavanese(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                      color: MainColors.textColor,
                      decoration: TextDecoration.none,
                    ),
                    delay: const Duration(milliseconds: 1400),
                  ),
                  const SizedBox(height: 8),
                  AnimatedTextWidget(
                    text:
                        '私たちは志摩市で最初に設立された\n介護施設として地域の皆さまと歩んできました。\n長年の経験と実績をもとに、\nこれからも安心とぬくもりの介護を提供してまいります。',
                    style: GoogleFonts.notoSansJavanese(
                      fontSize: 16,
                      color: MainColors.textColor,
                      height: 1.7,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                    delay: const Duration(milliseconds: 1800),
                  ),
                ],
              ),
            ),
            // メニュー部分を復元
            ContentsMumu(
              onMenuSelected: (menuType) {
                // 正しい構文でコールバックを渡す
                widget.onMenuSelected(menuType); // 親のonMenuSelectedを呼び出す
              },
            ),

            // 3. お知らせリスト部分
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: width * 0.8, // 幅を画面幅の80%に設定
                    height: 500,
                    padding: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MainColors.accentColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: topics.map((topic) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${topic.date}　',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: MainColors.textColor,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    topic.content,
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      color: MainColors.textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: MainColors.primaryColor,
                      ),
                      padding: const EdgeInsets.only(left: 20, top: 4),
                      child: const Text(
                        'お知らせ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. AddressUnit ウィジェット
            const AddressUnit(),
            const SizedBox(height: 40), // 下部の余白
          ],
        ),
      ),
    );
  }
}
