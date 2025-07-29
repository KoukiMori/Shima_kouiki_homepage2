// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shime_kouiki_homepage/contents_text.dart';
import 'package:shime_kouiki_homepage/top_page.dart';

class ContentsMumu extends StatefulWidget {
  const ContentsMumu({
    Key? key,
    required this.onMenuSelected,
  }) : super(key: key);

  final Function(MenuType) onMenuSelected;

  @override
  State<ContentsMumu> createState() => _ContentsMumuState();
}

class _ContentsMumuState extends State<ContentsMumu>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late List<AnimationController> _itemControllers;

  @override
  void initState() {
    super.initState();

    // メイン背景アニメーション
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    // 各メニューアイテム用のアニメーションコントローラー
    _itemControllers = List.generate(
        4,
        (index) => AnimationController(
              duration: Duration(milliseconds: 600 + (index * 150)), // スタガード効果
              vsync: this,
            ));

    // アニメーション開始
    _startAnimations();
  }

  void _startAnimations() async {
    // 背景画像のアニメーション開始
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _controller.forward();
    }

    // メニューアイテムのアニメーションを順次開始
    for (int i = 0; i < _itemControllers.length; i++) {
      await Future.delayed(Duration(milliseconds: 300 + (i * 200)));
      if (mounted) {
        _itemControllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildAnimatedMenuItem({
    required int index,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _itemControllers[index],
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(
            0,
            50 * (1 - _itemControllers[index].value), // 下から上へスライド
          ),
          child: Opacity(
            opacity: _itemControllers[index].value,
            child: Transform.scale(
              scale: 0.8 + (0.2 * _itemControllers[index].value), // 小さくから拡大
              child: child,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.fromLTRB(80, 0, 80, 0),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  SizedBox(
                    width:
                        width * 0.7 > 1500 ? 1500 : width * 0.7, // 1500px制限を考慮
                    height: 600, // 高さを固定
                    child: Image.asset(
                      'assets/images/hands.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: -20,
                    child: Column(
                      children: [
                        _buildAnimatedMenuItem(
                          index: 1,
                          child: ContentsText(
                            onTap: () {},
                            title: '施設紹介',
                            assetsName: 'assets/images/light2.png',
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
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 入所の流れ - 中央配置
                            _buildAnimatedMenuItem(
                              index: 2,
                              child: ContentsText(
                                onTap: () {
                                  widget
                                      .onMenuSelected(MenuType.nyushononagare);
                                },
                                title: '入所の流れ',
                                showArrow: false,
                                assetsName: 'assets/images/light3.png',
                              ),
                            ),
                            // その他 - 右側配置
                            _buildAnimatedMenuItem(
                              index: 3,
                              child: ContentsText(
                                onTap: () {},
                                title: 'その他',
                                assetsName: 'assets/images/light4.png',
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
                                      widget.onMenuSelected(MenuType.sonota);
                                    },
                                    showArrow: false,
                                  ),
                                ],
                                showArrow: true,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
