
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/utils/validator.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../Settings/widgets/custom_icon_elevated_button.dart';
import '../../../../../model/logged_in_user.dart';

class AddStoryScreen extends StatefulWidget {
  static const route = '/add-story-screen';
  const AddStoryScreen({super.key});

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String value = "Anyone";
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
          child: CustomIconElevatedButton(
              bgcolor: PColors.black2.withOpacity(0.9),
              textColor: PColors.whiteOff.withOpacity(0.6),
              text: "Upload media",
              borderRadius: 1,
              onPressed: () {
                getImage(ImageSource.gallery);
                // showBottomSheet(
                //   shape: BeveledRectangleBorder(),
                //   backgroundColor: PColors.seed2,
                //   context: context,
                //   builder: (ctx) => Column(children: [],)
                // );
              },
              icon: Image.asset(
                PImages.photo,
                color: PColors.whiteOff.withOpacity(0.9),
              )),
        ),
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
                trailing: InkWell(
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (url == null) {
                        EasyLoading.showError('Please select media');
                      } else {
                        context.read<StoryViewModel>().createStory(
                            url: url ?? '',
                            description: _descriptionController.text,
                            archived: value == 'Anyone',
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
              Form(
                key: _formKey,
                child: CustomTextFeild(
                    controller: _descriptionController,
                    maxLine: 20,
                    keyboardType: TextInputType.multiline,
                    borderColor: PColors.black,
                    hintText: 'Share your thoughts',
                    validation: Validator.text,
                    filColor: PColors.black),
              ),
              const SizedBox(height: 10),
              if (url != null) Image.network(url!, fit: BoxFit.cover),
              const SizedBox(
                height: 20,
              )
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

  Widget sheet() {
    return Container(
      width: 360,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: PColors.white,
                    )),
              ],
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera, color: PColors.white),
              title: textWidget(text: "Camera", color: PColors.white),
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo, color: PColors.white),
              title: textWidget(text: 'Gallery', color: PColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String? imageUrl = await context
          .read<FileUploadViewModel>()
          .pickedImageUpload(image, 'Story');
      setState(() {
        url = imageUrl;
      });
    }
  }
}
