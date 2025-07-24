import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shime_kouiki_homepage/address_unit.dart';

class TopPageContents extends StatefulWidget {
  const TopPageContents({super.key});

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity, // 全体の幅を調整
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // テキスト（上から下へのアニメーション）
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ), // hands.png 画像（左から右へのアニメーション）
            Container(
              color: Colors.green,
              width: width, // 最大幅を画面幅の70%に制限
              height: 800,
              child: Image.asset(
                'assets/images/hands.png',
                fit: BoxFit.none,
                scale: 2, // 高さに合わせてフィット
              ),
            ),
            const AddressUnit()
          ],
        ),
      ),
    );
  }
}
