import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shime_kouiki_homepage/contents_text.dart'; // ContentsTextをインポート
import 'package:shime_kouiki_homepage/top_page.dart'; // MenuTypeをインポートするため
import 'package:shime_kouiki_homepage/topic.dart'; // Topicモデルをインポート
import 'package:shime_kouiki_homepage/address_unit.dart'; // AddressUnitをインポート
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
              padding: const EdgeInsets.symmetric(vertical: 40.0), // 上下の余白
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '1977年',
                    style: GoogleFonts.zenAntique(
                        fontSize: 80,
                        fontWeight: FontWeight.w300,
                        height: 1.1,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ),
                  Text(
                    '志摩の介護',
                    style: GoogleFonts.zenAntique(
                        fontSize: 41,
                        fontWeight: FontWeight.w300,
                        height: 1.2,
                        decoration: TextDecoration.none,
                        color: Colors.black),
                  ),
                  Text(
                    'ここから始まりました。',
                    style: GoogleFonts.zenAntique(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    '私たちは、志摩市で最初に設立された\n介護施設として、地域の皆さまと歩んできました。\n長年の経験と実績をもとに、\nこれからも安心とぬくもりの介護を提供してまいります。',
                    style: GoogleFonts.zenAntique(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.7,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            // メニュー部分を復元
            Container(
              margin: const EdgeInsets.fromLTRB(80, 50, 80, 0),
              child: Row(
                spacing: 18,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // トップページボタン
                  ContentsText(
                    onTap: () {
                      widget.onMenuSelected(MenuType.home);
                    },
                    title: 'トップページ',
                    showArrow: false,
                  ),
                  // 施設紹介
                  ContentsText(
                    onTap: () {},
                    title: '施設紹介',
                    subMenu: [
                      ContentsText(
                        title: '才庭寮',
                        onTap: () {
                          widget.onMenuSelected(MenuType.sainiwaryo);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: 'ともやま苑',
                        onTap: () {
                          widget.onMenuSelected(MenuType.tomoyamaen);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: '花園寮',
                        onTap: () {
                          widget.onMenuSelected(MenuType.hanazonoryo);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: '福祉センター',
                        onTap: () {
                          widget.onMenuSelected(MenuType.fukushicenter);
                        },
                        showArrow: false,
                      ),
                    ],
                  ),
                  // 入所の流れ
                  ContentsText(
                    onTap: () {
                      widget.onMenuSelected(MenuType.nyushononagare);
                    },
                    title: '入所の流れ',
                    showArrow: false,
                  ),
                  // その他
                  ContentsText(
                    onTap: () {
                      widget.onMenuSelected(MenuType.sonota);
                    },
                    title: 'その他',
                    subMenu: [
                      ContentsText(
                        title: '組合概要',
                        onTap: () {
                          widget.onMenuSelected(MenuType.kumiai);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: '例規集',
                        onTap: () {
                          widget.onMenuSelected(MenuType.reikishu);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: '入札情報',
                        onTap: () {
                          widget.onMenuSelected(MenuType.nyusatsu);
                        },
                        showArrow: false,
                      ),
                      ContentsText(
                        title: '取り組みについて',
                        onTap: () {
                          widget.onMenuSelected(MenuType.sonota); // 仮にsonotaに設定
                        },
                        showArrow: false,
                      ),
                    ],
                    showArrow: true, // ここをtrueに変更
                  ),
                ],
              ),
            ),

            // 2. hands.png 画像部分
            SizedBox(
              width: width * 0.7 > 1500 ? 1500 : width * 0.7, // 1500px制限を考慮
              height: 400, // 高さを固定
              child: Image.asset(
                'assets/images/hands.png',
                fit: BoxFit.contain, // または BoxFit.fitHeight
                // scale: 2, // 必要に応じて調整
                // colorBlendMode: BlendMode.screen, // 必要に応じて調整
              ),
            ),

            // 3. お知らせリスト部分
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: width * 0.8, // 幅を画面幅の80%に設定
                    height: 500,
                    padding: const EdgeInsets.only(
                        top: 50, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
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
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    topic.content,
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      color: Colors.grey.shade800,
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
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.blue,
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
