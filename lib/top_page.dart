import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面幅を取得
    final double width = MediaQuery.of(context).size.width;
    final Color bgColor = const Color.fromARGB(255, 250, 251, 255);

    // ブレークポイント判定
    // PC: 768px以上, タブレット: 481~767px, スマホ: 480px以下
    Widget content;
    if (width >= 768) {
      // PC用（全体幅は1200px上限で可変、1200px以上は1200px固定。左カラム300px固定、右は残り幅）
      final double containerWidth = width > 1200 ? 1200 : width;
      content = SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * .06),
            width: containerWidth,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 300,
                        color: bgColor,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(60, 80, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  scale: 8,
                                ),
                              ),
                              const SizedBox(height: 60),
                              Column(
                                spacing: 18,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ContentsText(
                                    onTap: () {},
                                    title: '施設紹介',
                                    subMenu: [
                                      ContentsText(
                                          title: '才庭寮',
                                          onTap: () {},
                                          showArrow: false),
                                      ContentsText(
                                          title: 'ともやま苑',
                                          onTap: () {},
                                          showArrow: false),
                                      ContentsText(
                                          title: '花園寮',
                                          onTap: () {},
                                          showArrow: false),
                                      ContentsText(
                                          title: '福祉センター',
                                          onTap: () {},
                                          showArrow: false),
                                    ],
                                  ),
                                  ContentsText(
                                      onTap: () {},
                                      title: '入所の流れ',
                                      showArrow: false),
                                  ContentsText(
                                      onTap: () {},
                                      title: '組合概要',
                                      showArrow: false),
                                  ContentsText(
                                      onTap: () {},
                                      title: '例規集',
                                      showArrow: false),
                                  ContentsText(
                                      onTap: () {},
                                      title: '入札情報',
                                      showArrow: false),
                                  ContentsText(
                                      onTap: () {},
                                      title: 'その他',
                                      showArrow: false),
                                  ContentsText(
                                    onTap: () {},
                                    title: '住所連絡先',
                                    subMenu: [
                                      Column(
                                        spacing: 10,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          Image.asset(
                                            "assets/images/map.png",
                                            scale: 6,
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              final url = Uri.parse(
                                                  'https://maps.app.goo.gl/XPQcFxXa6chUwxsq8');
                                              await launchUrl(url);
                                            },
                                            child: Row(
                                              spacing: 10,
                                              children: [
                                                Image.asset(
                                                  'assets/images/Google_Maps_Logo_2020.svg.png',
                                                  scale: 15,
                                                ),
                                                const TextContent(
                                                  title: 'Googleマップで探す',
                                                  textSize: 14,
                                                  textWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 8,
                                        children: [
                                          TextContent(
                                            title: '三重県志摩市阿児町神明1537-1',
                                            textSize: 14,
                                          ),
                                          TextContent(
                                            title: '電話 0599-43-211',
                                            textSize: 14,
                                          ),
                                          TextContent(
                                            title: 'Fax 0599-43-7279',
                                            textSize: 14,
                                          ),
                                          TextContent(
                                            title:
                                                'E-mail sikouiki@shima.mctv.ne.jpv',
                                            textSize: 14,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.orange.shade100,
                        ), // 右カラムは残り幅
                      ),
                    ],
                  ),
                ),
                const JobTab(),
              ],
            ),
          ),
        ),
      );
    } else if (width > 480 && width < 768) {
      // タブレット用
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
          const JobTab()
        ],
      );
    } else {
      // スマホ用
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
          const JobTab()
        ],
      );
    }

    // 分岐したウィジェットを返す
    return content;
  }
}

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
  });

  @override
  State<ContentsText> createState() => _ContentsTextState();
}

class _ContentsTextState extends State<ContentsText> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.onTap,
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
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      fontSize: _isHover ? 16 : 14,
                      fontWeight: _isHover ? FontWeight.bold : FontWeight.w400,
                      color: _isHover ? Colors.white : Colors.black,
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
                        color: _isHover ? Colors.white : Colors.black,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_isHover && widget.subMenu != null)
            AnimatedSize(
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
              child: AnimatedOpacity(
                opacity: _isHover ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.subMenu!
                      .map((sub) => Padding(
                            padding: const EdgeInsets.only(left: 16, top: 6),
                            child: sub,
                          ))
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
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

class TextContent extends StatelessWidget {
  final String title;
  final Color color;
  final double textSize;
  final FontWeight textWeight;
  const TextContent({
    super.key,
    required this.title,
    this.textSize = 12,
    this.color = Colors.black,
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
          color:
              _isHover ? const Color.fromARGB(255, 80, 105, 246) : Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}
