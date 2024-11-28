
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
import '../../../../video_player/video_player.dart';

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
  String value = 'Anyone';
  @override
  Widget build(BuildContext context) {
    StoryViewModel storyViewModel = context.watch<StoryViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
          child: CustomIconElevatedButton(
              bgcolor: PColors.black2.withOpacity(0.9),
              textColor: PColors.whiteOff.withOpacity(0.6),
              text: 'Upload media',
              borderRadius: 1,
              onPressed: () {
showModalBottomSheet(context: context, backgroundColor: PColors.seed2, builder: (ctx) {
  return Container(
      width: 360,
      height: 250,
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
              title: textWidget(text: 'Camera', color: PColors.white),
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo, color: PColors.white),
              title: textWidget(text: 'Gallery', color: PColors.white),
            ),
                     ListTile(
              onTap: () {Navigator.pop(ctx);
               _pickVideo(context);
              },
              leading: Icon(Icons.videocam_rounded, color: PColors.white),
              title: textWidget(text: 'Video', color: PColors.white),
            ),
          ],
        ),
      ),
    );
},);
            //      showBottomSheet(
            //   shape: const BeveledRectangleBorder(),
            //   backgroundColor: PColors.seed2,
            //   context: context,
            //   builder: (context) => sheet(),
            // );
                // getImage(ImageSource.gallery);
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
                      items: <String>['Anyone', 'Followers'].map((String value) {
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
                      if (storyViewModel.selectedUrl == null) {
                        EasyLoading.showError('Please select media');
                      } else {
                        context.read<StoryViewModel>().createStory(
                            url: storyViewModel.selectedUrl ?? '',
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
                    maxLine: 20,
                    keyboardType: TextInputType.multiline,
                    borderColor: PColors.black,
                    hintText: 'Share your thoughts',
                    validation: Validator.text,
                    filColor: PColors.black),
              ),
              const SizedBox(height: 10),
               if (storyViewModel.selectedUrl != null &&
                  storyViewModel.selectedMediaType == 'image')
                Image.network(storyViewModel.selectedUrl!, fit: BoxFit.cover),
              if (storyViewModel.selectedUrl != null &&
                  storyViewModel.selectedMediaType == 'video')
                InkWell(onTap: () {
          Navigator.push(context , MaterialPageRoute(builder:  (context) => VideoViewScreen(videoUrl:storyViewModel.selectedUrl??'')));
        } ,
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

 void _pickVideo(BuildContext context) async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.video,
  );

  // final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

  //    if (video != null) {
  //     String? url = await context
  //         .read<FileUploadViewModel>()
  //         .pickedImageUpload(video, 'Post');
  //          PostViewModel postProvider = context.read<PostViewModel>();
  //   postProvider.selectedMediaType='video';
  //    postProvider.selectedUrl = url;
  //    log(postProvider.selectedUrl.toString());
  //   }

  if (pickedFile != null && pickedFile.files.isNotEmpty) {
    final Uint8List fileBytes = pickedFile.files.first.bytes ?? Uint8List(0);
    FileUploadViewModel provider = context.read<FileUploadViewModel>();
    StoryViewModel storyViewModel = context.read<StoryViewModel>();
    storyViewModel.selectedMediaType='video';
  storyViewModel.selectedUrl  = await provider.pickedVideoUpload(
        fileBytes, pickedFile.files.first.name);
  } else {
    debugPrint('No file was picked');
  }
}

  Future getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String? imageUrl = await context
          .read<FileUploadViewModel>()
          .pickedImageUpload(image, 'Story');
      StoryViewModel storyViewModel = context.read<StoryViewModel>();
    storyViewModel.selectedMediaType='image';
    storyViewModel.selectedUrl=imageUrl;
    }
  }
}
