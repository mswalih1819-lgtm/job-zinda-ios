import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/features/upload_pages/view/widgets/dropdown_widget.dart';
import 'package:jora_customer/features/upload_pages/view/widgets/upload_button.dart';

class AddPostUi extends StatelessWidget {
  const AddPostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: UploadButtonUi(),
      ),
      // floatingActionButton: UploadButtonUi(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ListTile(
                contentPadding: EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(PImages.pro_pic3),
                ),
                title: DropdownWidgetUi(),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: PColors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 6),
                    child: textWidget(
                        text: "Post",
                        color: PColors.black,
                        fontweight: FontWeight.w500,
                        fontsize: 14),
                  ),
                ),
              ),
              CustomTextFeild(
                  maxLine: 20,
                  keyboardType: TextInputType.multiline,
                  borderColor: PColors.black,
                  hintText: "Share your thoughts",
                  onSaved: (val) {},
                  onChanged: (val) {},
                  validation: (val) {},
                  filColor: PColors.black),
              // Column(
              //   children: [

              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
