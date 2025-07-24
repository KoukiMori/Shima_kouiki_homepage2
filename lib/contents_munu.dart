import 'package:flutter/material.dart';
import 'package:shime_kouiki_homepage/contents_text.dart';
import 'package:shime_kouiki_homepage/top_page.dart';

class ContentsMumu extends StatelessWidget {
  const ContentsMumu({
    super.key,
    required this.onMenuSelected,
  });

  final Function(MenuType) onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(80, 50, 80, 0),
      child: Row(
        spacing: 18,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ContentsText(
            onTap: () {
              onMenuSelected(MenuType.home);
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
                  onMenuSelected(MenuType.sainiwaryo);
                },
                showArrow: false,
              ),
              ContentsText(
                title: 'ともやま苑',
                onTap: () {
                  onMenuSelected(MenuType.tomoyamaen);
                },
                showArrow: false,
              ),
              ContentsText(
                title: '花園寮',
                onTap: () {
                  onMenuSelected(MenuType.hanazonoryo);
                },
                showArrow: false,
              ),
              ContentsText(
                title: '福祉センター',
                onTap: () {
                  onMenuSelected(MenuType.fukushicenter);
                },
                showArrow: false,
              ),
            ],
          ),
          // 入所の流れ
          ContentsText(
            onTap: () {
              onMenuSelected(MenuType.nyushononagare);
            },
            title: '入所の流れ',
            showArrow: false,
          ),
          // その他
          ContentsText(
            onTap: () {
              onMenuSelected(MenuType.sonota);
            },
            title: 'その他',
            subMenu: [
              ContentsText(
                title: '組合概要',
                onTap: () {
                  onMenuSelected(MenuType.kumiai);
                },
                showArrow: false,
              ),
              ContentsText(
                title: '例規集',
                onTap: () {
                  onMenuSelected(MenuType.reikishu);
                },
                showArrow: false,
              ),
              ContentsText(
                title: '入札情報',
                onTap: () {
                  onMenuSelected(MenuType.nyusatsu);
                },
                showArrow: false,
              ),
              ContentsText(
                title: '取り組みについて',
                onTap: () {
                  onMenuSelected(MenuType.sonota); // 仮にsonotaに設定
                },
                showArrow: false,
              ),
            ],
            showArrow: true, // ここをtrueに変更
          ),
        ],
      ),
    );
  }
}
