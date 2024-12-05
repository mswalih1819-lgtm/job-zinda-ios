import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/model/story_model.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';

class DisplayStoryPage extends StatelessWidget {
  final StoryController controller = StoryController();
  TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StoryViewModel>(
        builder: (context, value, child) => Stack(
          children: [
            StoryView(
              storyItems: _buildStoryItems(value.storyModel),
              onStoryShow: (storyItem, _) {
                print("Showing a story: ${storyItem.view}");
              },
              onComplete: () {
                print("Story completed!");
                Navigator.pop(context);
              },
              controller: controller,
              repeat: false,
            ),
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      // child: CustomTextFeild(hintText: "Add a comment", filColor: PColors.whiteOff,borderRadius: 25,),
                      child: TextField(
                        controller: _commentController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: "Add a comment...",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22)),
                            filled: true),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        // _addComment();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<StoryItem> _buildStoryItems(StoryModel story) {
    return story.media!.map<StoryItem>((story) {
      switch (story.mediaType) {
        // case "text":
        //   return StoryItem.text(
        //     title: story.bio,
        //     backgroundColor:  Colors.black,
        //     textStyle: TextStyle(
        //       fontSize: 25,
        //       color: Colors.white,
        //     ),
        //   );
        case "image":
          return StoryItem.pageImage(
            url: story.content.toString(),
            // caption: story["caption"] ?? "",
            controller: controller,
          );
        case "video":
          return StoryItem.pageVideo(
            story.content.toString(),
            // caption: story["caption"] ?? "",
            controller: controller,
          );
        default:
          return StoryItem.text(
            title: "Invalid story type",
            backgroundColor: Colors.grey,
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          );
      }
    }).toList();
  }
}
