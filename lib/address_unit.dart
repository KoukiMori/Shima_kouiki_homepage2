import 'package:flutter/material.dart';
import 'package:shime_kouiki_homepage/content_text.dart';
import 'package:shime_kouiki_homepage/top_page.dart';
import 'package:url_launcher/url_launcher.dart';

class AddressUnit extends StatelessWidget {
  const AddressUnit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            const TextContent(
              title: '三重県志摩市阿児町神明1537-1',
              textSize: 14,
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () async {
                final url =
                    Uri.parse('https://maps.app.goo.gl/XPQcFxXa6chUwxsq8');
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
        const TextContent(
          title: '電話 0599-43-211',
          textSize: 14,
        ),
        const TextContent(
          title: 'Fax 0599-43-7279',
          textSize: 14,
        ),
        const TextContent(
          title: 'E-mail sikouiki@shima.mctv.ne.jpv',
          textSize: 14,
        ),
      ],
    );
  }
}
