import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';

class SendFeedbackUi extends StatefulWidget {
  const SendFeedbackUi({super.key});

  @override
  State<SendFeedbackUi> createState() => _SendFeedbackUiState();
}

class _SendFeedbackUiState extends State<SendFeedbackUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textWidget(text: "Send feedback"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  textWidget(
                    text: "Write your feedback below",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFeild(
                      borderRadius: 0,
                      maxLine: 10,
                      hintText: "",
                      onSaved: (val) {},
                      onChanged: (val) {},
                      validation: (val) {},
                      filColor: PColors.seed),
                  SizedBox(
                    height: 30,
                  ),
                  starSection(context)
                ],
              ),
            ),
            button()
          ],
        ),
      ),
    );
  }

  Widget button() {
    return CustomElavatedTextButton(
      width: double.infinity,
      text: "Send",
      onPressed: () {},
      bgcolor: PColors.white,
      textColor: PColors.black,
      borderRadius: 0,
    );
  }

  double rating = 0;

  Widget starSection(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        textWidget(text: "Optional"),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 7),
              child: StarRating(
                rating: rating,
                size: 45,
                
                borderColor: PColors.yellow,
                color: PColors.yellow,
                starCount: 5,
                allowHalfRating: true,
                onRatingChanged: (rating) => setState(() => this.rating = rating),
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        textWidget(text: "Rate your experience with Jora")
      ],
    );
  }
}
