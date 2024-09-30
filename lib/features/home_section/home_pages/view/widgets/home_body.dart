import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/home_section/home_pages/view/widgets/home_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../wrapper/view_model/view_model.dart';

class HomeBodyUi extends StatelessWidget {
  const HomeBodyUi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) => singleWidget(context),
    );
  }

  Widget singleWidget(BuildContext context) {
    return Column(
      children: [
        userDataWidget(context),
        imageWidget(),
        SizedBox(
          height: 10,
        ),
        actionWidget(),
        captionWidget()
      ],
    );
  }

  Widget imageWidget() {
    return Image.asset(PImages.post_pic);
  }

  Widget userDataWidget(BuildContext context) {
    return ListTile(
      onTap: () {
        context
            .read<WrapperViewModel>()
            .updatePageView(WrapperViewStatus.otherProfile);
      },
      contentPadding: EdgeInsets.zero,
      title: textWidget(text: "Jessica12", color: PColors.white),
      subtitle: textWidget(
          text: "Photographer", color: PColors.whiteOff.withOpacity(0.5)),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(PImages.pro_pic2),
      ),
      trailing: GestureDetector(
          onTap: () {
            showBottomSheet(
              shape: BeveledRectangleBorder(),
              clipBehavior: Clip.hardEdge,
              backgroundColor: PColors.black,
              context: context,
              builder: (context) => HomeBottomsheetUi(),
            );
          },
          child: Icon(
            Icons.more_horiz,
            color: PColors.white,
          )),
    );
  }

  Widget actionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              PSvgs.heart,
              height: 24,
            ),
            SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              PSvgs.chat,
              height: 24,
            ),
            SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              PSvgs.share,
              height: 24,
            ),
          ],
        ),
        Row(
          children: [
            textWidget(
                text: "100 like",
                color: PColors.whiteOff.withOpacity(0.6),
                fontsize: 12),
            SizedBox(
              width: 6,
            ),
            textWidget(
                text: "100 comments",
                color: PColors.whiteOff.withOpacity(0.6),
                fontsize: 12),
          ],
        )
      ],
    );
  }

  Widget captionWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadMoreText(
            'Hello Gz.. Good morning😎 \ndon’t forgot to follow and comment this post. hellllll',
            trimMode: TrimMode.Line,
            style: TextStyle(color: PColors.whiteOff),
            // delimiterStyle: TextStyle(color: PColors.seed,fontWeight: FontWeight.bold,),
            trimLines: 1,
            colorClickableText: PColors.whiteOff.withOpacity(0.5),
            trimCollapsedText: 'view more',
            trimExpandedText: 'show less',

            moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: PColors.whiteOff.withOpacity(0.5),
                height: 2),
          ),
          textWidget(
              text: "2h ago",
              color: PColors.whiteOff.withOpacity(0.5),
              fontsize: 11)
        ],
      ),
    );
  }
}
