import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/Settings/widgets/custom_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class FreeLancerEditProfileUi extends StatelessWidget {
  const FreeLancerEditProfileUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColors.black,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: button(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProfileViewModel>(
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                    text: "Create your account",
                    fontsize: 18,
                    fontweight: FontWeight.bold),
                SizedBox(
                  height: 10,
                ),
                textWidget(text: "Profile Photo"),
                SizedBox(
                  height: 10,
                ),
                value.profileModel!.profileImageUrl == null ||value.profileModel!.profileImageUrl!.isEmpty
                    ? uploadImage(type: "profile", context: context)
                    : imageWidget(
                        imageurl: value.profileModel!.profileImageUrl!,
                        type: "profile",
                        context: context),
                SizedBox(
                  height: 10,
                ),
                textWidget(text: "Cover Photo"),
                SizedBox(
                  height: 10,
                ),
                value.profileModel!.coverImage == null||value.profileModel!.coverImage!.isEmpty
                    ? uploadImage(type: "cover", context: context)
                    : imageWidget(
                        imageurl: value.profileModel!.coverImage!,
                        type: "cover",
                        context: context),
                // Expanded(child: Container()),
                SizedBox(height: 20,),
                button(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadImage({required String type, required BuildContext context}) {
    return GestureDetector(
      onTap: () async {
        XFile? image =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        if (image != null) {
          if (type == "cover") {
            String url = await context
                    .read<FileUploadViewModel>()
                    .pickedImageUpload(image, 'Cover') ??
                '';

            context.read<ProfileViewModel>().updateCoverImage(url: url);
          } else {
            String url = await context
                    .read<FileUploadViewModel>()
                    .pickedImageUpload(image, 'Profile') ??
                '';

            context.read<ProfileViewModel>().updateProfileImage(url: url);
          }
        }
      },
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: [4, 4, 4, 4],
        color: PColors.whiteOff.withOpacity(0.4),
        radius: Radius.circular(0),
        padding: EdgeInsets.all(25),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(PSvgs.upload_image),
                SizedBox(
                  height: 10,
                ),
                textWidget(text: "Upload Image"),
                SizedBox(
                  height: 10,
                ),
                textWidget(
                    text:
                        "Support PNG, JPEG, WEBP files, maximum size 10MB Maximum Resolution 2048 * 2048",
                    color: PColors.whiteOff.withOpacity(0.4),
                    textAlign: TextAlign.center)
              ],
            )),
      ),
    );
  }

  Widget imageWidget(
      {required String imageurl,
      required BuildContext context,
      required String type}) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.network(
              imageurl,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
              onTap: () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (image != null) {
                  if (type == "cover") {
                    String url = await context
                            .read<FileUploadViewModel>()
                            .pickedImageUpload(image, 'Cover') ??
                        '';

                    context.read<ProfileViewModel>().updateCoverImage(url: url);
                  } else {
                    String url = await context
                            .read<FileUploadViewModel>()
                            .pickedImageUpload(image, 'Profile') ??
                        '';

                    context
                        .read<ProfileViewModel>()
                        .updateProfileImage(url: url);
                  }
                }
              },
              child: Icon(Icons.edit))
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomElavatedTextButton(
          width: double.infinity,
          text: "Next",
          borderRadius: 0,
          bgcolor: PColors.white,
          onPressed: () {
            Navigator.pushNamed(context, PPages.freelancerBioPageUi);
          },
          textColor: PColors.black,
        ),
        SizedBox(
          height: 10,
        ),
        CustomElavatedTextButton(
          text: "Skip for now",
          onPressed: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, PPages.freelancerBioPageUi);
          },
          borderRadius: 0,
          width: double.infinity,
          textColor: PColors.white,
          bgcolor: PColors.seed2,
        )
      ],
    );
  }
}
