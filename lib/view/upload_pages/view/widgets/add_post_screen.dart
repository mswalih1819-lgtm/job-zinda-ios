import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view/upload_pages/view/widgets/upload_button.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/story_view_model.dart';

class AddPostScreen extends StatefulWidget {
   AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String value = "Anyone";
  @override
  Widget build(BuildContext context) {  PostViewModel postViewModel =context.watch<PostViewModel>();
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
                title: Container(
      width: 100.0,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          isDense: true,
          dropdownColor: PColors.black2,
          value: value,
          // isExpanded: true,
          style: TextStyle(color: PColors.whiteOff),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: PColors.whiteOff,
          ),
          underline: SizedBox(),
          items: <String>['Anyone', 'Nobody'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: PColors.whiteOff),
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              value = val!;
            });
          },
        ),
      ),
    ),
                trailing: InkWell(onTap: () {
                

                               if (_formKey.currentState?.validate() ?? false) {
                      if (postViewModel.selectedUrl == null) {
                        EasyLoading.showError('Please select media');
                      } else {
                       postViewModel.createPost(
                            description: _descriptionController.text,
                            sharedWith: value,
                            context: context);
                      }
                    }
                },
                  child: Container(
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
              ),
              Form(key: _formKey,
                child: CustomTextFeild(controller: _descriptionController,
                    maxLine: 20,
                    keyboardType: TextInputType.multiline,
                    borderColor: PColors.black,
                    hintText: "Share your thoughts",
                    onSaved: (val) {},
                    onChanged: (val) {},
                    validation:Validator.text,
                    filColor: PColors.black),
              ),
          SizedBox(height: 10),
              if (postViewModel.selectedUrl != null) Image.network(postViewModel.selectedUrl!, fit: BoxFit.cover),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
