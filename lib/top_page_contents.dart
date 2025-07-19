import 'package:flutter/material.dart';

class TopPageContents extends StatelessWidget {
  const TopPageContents({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      // color: Colors.greenAccent,
      // 画像とテキストを重ねてレイアウト
      child: SizedBox(
        width: 800, // 全体の幅を調整
        height: 400, // 全体の高さを調整
        child: Stack(
          children: [
            // テキスト（右上に配置）
            Positioned(
              right: 40,
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                width: width * .4,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 229, 235, 252),
                ),
                child: Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '1977年',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '志摩の介護',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'ここから\n始まりました。',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '私たちは、\n志摩市で最初に設立された介護施設として、\n地域の皆さまと歩んできました。\n長年の経験と実績をもとに、\nこれからも安心とぬくもりの\n介護を提供してまいります。',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ), // 車椅子画像（左下に配置）
            Positioned(
              top: 170,
              left: -120,
              child: Image.asset(
                'assets/images/car_chair.png',
                scale: 2,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
