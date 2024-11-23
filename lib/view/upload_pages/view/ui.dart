import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class UploadPagesUi extends StatelessWidget {
  const UploadPagesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 20,
                    )),
                SizedBox(
                  width: 10,
                )
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, PPages.addPostUi);
              },
              leading: SvgPicture.asset(PSvgs.share_post),
              title: textWidget(text: "Share new post", color: PColors.white),
            ),
            ListTile(
              leading: SvgPicture.asset(
                PSvgs.share_story,
              ),
              title: textWidget(
                text: "Share story",
                color: PColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
