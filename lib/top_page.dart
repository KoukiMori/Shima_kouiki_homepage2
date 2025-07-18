import 'package:flutter/material.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面幅を取得
    final double width = MediaQuery.of(context).size.width;

    // ブレークポイント判定
    // PC: 768px以上, タブレット: 481~767px, スマホ: 480px以下
    Widget content;
    if (width >= 768) {
      // PC用（全体幅は1200px上限で可変、1200px以上は1200px固定。左カラム300px固定、右は残り幅）
      final double containerWidth = width > 1200 ? 1200 : width;
      content = Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width * .06),
          width: containerWidth,
          child: Row(
            children: [
              Container(
                width: 300, // 左カラムは常に300px固定
                color: const Color.fromARGB(255, 250, 251, 255),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: width * .03, horizontal: width * .04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Image.asset(
                          'assets/images/logo.png',
                          scale: 10,
                        ),
                      ),
                      SizedBox(height: width * .06),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft),
                            child: const TextContent(title: '施設紹介'),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft),
                            child: TextContent(title: '入所の流れ'),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft),
                            child: const TextContent(title: '組合概要'),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                side: BorderSide.none,
                                alignment: Alignment.centerLeft),
                            child: const TextContent(title: '例規集'),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft),
                            child: const TextContent(title: '入札情報'),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                alignment: Alignment.centerLeft),
                            child: const TextContent(title: 'その他'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(color: Colors.blue), // 右カラムは残り幅
              ),
            ],
          ),
        ),
      );
    } else if (width > 480 && width < 768) {
      // タブレット用
      content = Container(
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
      );
    } else {
      // スマホ用
      content = Container(
        margin: EdgeInsets.symmetric(horizontal: width * .02),
        color: Colors.green,
        child: Column(
          children: [
            Container(
              height: 60,
              color: Colors.red,
            ),
            Container(
              height: 120,
              color: Colors.blue,
            ),
          ],
        ),
      );
    }

    // 分岐したウィジェットを返す
    return content;
  }
}

class TextContent extends StatelessWidget {
  final String title;
  const TextContent({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}
