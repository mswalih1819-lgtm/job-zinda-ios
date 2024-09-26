import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/features/upload_pages/view/widgets/dropdown_widget.dart';
import 'package:jora_customer/features/upload_pages/view/widgets/upload_button.dart';

class AddPostUi extends StatelessWidget {
  const AddPostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: 
            Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: UploadButtonUi(),
            ),
      // floatingActionButton: UploadButtonUi(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(PImages.pro_pic3),
              ),
              title: DropdownWidgetUi(),
              trailing: CustomElavatedTextButton(
                width: 100,
                borderRadius: 10,
                height: 38,
                text: "Post",
                onPressed: () {},
                bgcolor: PColors.white,
                textColor: PColors.black,
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
    );
  }
}
