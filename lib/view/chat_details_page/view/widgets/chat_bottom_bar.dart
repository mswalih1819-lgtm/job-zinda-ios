import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/view_model/chat_details_view_model.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:provider/provider.dart';

class ChatBottomBarUi extends StatelessWidget {
  ChatBottomBarUi({super.key});

  final TextEditingController _messageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    ChatDetailsViewModel chatDetailsViewModel =
        context.read<ChatDetailsViewModel>();
    return Padding(
      padding: EdgeInsets.all(0),
      // EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 14),
        width: MediaQuery.of(context).size.width,
        // color:PColors.seed2,
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                // controller: _messageController,
                decoration: inputDecoration(context),
                onChanged: (value) {
                  chatDetailsViewModel.updateTextContect(value);
                },
              ),
            ),
            const SizedBox(width: 25),
            if (chatDetailsViewModel.message != null &&
                chatDetailsViewModel.message!.isNotEmpty)
              GestureDetector(
                onTap: () {
                  if (chatDetailsViewModel.message != null &&
                      chatDetailsViewModel.message!.isNotEmpty) {
                    chatDetailsViewModel.sentmessage(context: context);
                    chatDetailsViewModel.fetchAllConversations(1);
                  }
                },
                child: Icon(Icons.send_outlined),
              ),
            if (chatDetailsViewModel.message == null ||
                chatDetailsViewModel.message!.isEmpty)
              // Send Button
              SvgPicture.asset(
                PSvgs.audio,
                height: 24,
              ),
            const SizedBox(width: 20)
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(BuildContext context) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide:
            BorderSide(color: PColors.whiteOff.withOpacity(0.4), width: 0.0),
      ),

      hintText: "",
      suffixIcon: suffixIcon(context),
      prefixIcon: prefixIcon(),
      // hintStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(color: PColors.whiteOff.withOpacity(0.4)),
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      width: 40,
      child: Center(
        child: SvgPicture.asset(
          PSvgs.emoji,
          height: 27,
        ),
      ),
    );
  }

  Widget suffixIcon(BuildContext context) {
    ChatDetailsViewModel chatDetailsViewModel =
        context.read<ChatDetailsViewModel>();
    return Container(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                getImage(context, ImageSource.gallery);
              },
              child: SvgPicture.asset(
                PSvgs.plus,
                height: 24,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                getImage(context, ImageSource.camera);
              },
              child: SvgPicture.asset(
                PSvgs.camera,
                height: 21,
                width: 7,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  Future getImage(BuildContext context, ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      String? url = await context
          .read<FileUploadViewModel>()
          .pickedImageUpload(image, 'chat');
      ChatDetailsViewModel chatDetailsViewModel =
          context.read<ChatDetailsViewModel>();
      chatDetailsViewModel.updateImageContect(context, url!);
      // chatDetailsViewModel.selectedUrl = url;
    }
  }
}
