import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view/upload_pages/view/widgets/upload_button.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';
import '../../../video_player/video_player.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String value = 'Anyone';
  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = context.watch<PostViewModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const UploadButtonUi(),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 10),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(LoggedInUser.profilePic ?? ''),
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
                      underline: const SizedBox(),
                      items:
                          <String>['Anyone', 'Followers'].map((String value) {
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
                trailing: InkWell(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // if (postViewModel.selectedUrl == null) {
                      //   EasyLoading.showError('Please select media');
                      // } else {
                         if(postViewModel.selectedUrl == null){
                          postViewModel.selectedMediaType="text";
                         }

                        postViewModel.createPost(
                            description: _descriptionController.text,
                            sharedWith: value,
                            context: context);
                      }
                    // }
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
                          text: 'Post',
                          color: PColors.black,
                          fontweight: FontWeight.w500,
                          fontsize: 14),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: CustomTextFeild(
                    controller: _descriptionController,
                    maxLine: 4,
                    keyboardType: TextInputType.multiline,
                    borderColor: PColors.black,
                    hintText: 'Share your thoughts',
                    validation: Validator.text,
                    filColor: PColors.black),
              ),
              const SizedBox(height: 10),
              if (postViewModel.selectedUrl != null &&
                  postViewModel.selectedMediaType == 'image')
                Image.network(postViewModel.selectedUrl!, fit: BoxFit.cover),
              if (postViewModel.selectedUrl != null &&
                  postViewModel.selectedMediaType == 'video')
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoViewScreen(
                                videoUrl: postViewModel.selectedUrl ?? '')));
                  },
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8)),
                    child: const Icon(
                      Icons.play_circle,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
