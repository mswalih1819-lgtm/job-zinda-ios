import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/model/myStory_model.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/linear_progress_indicator.dart';
import 'package:jora_customer/view/home_section/home_pages/view/widgets/views_sheet.dart';
// import 'package:jora_customer/model/myStory_model.dart';
import 'package:jora_customer/view_model/story_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class StoryViewer extends StatefulWidget {
  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  double _progress = 0.0;
  VideoPlayerController? _videoController;
  bool _isVideoLoading = false;

  @override
  void initState() {
    super.initState();
    _startAutoScrollTimer();
    _initializeVideo();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  void _startAutoScrollTimer() {
    _progress = 0.0;
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_videoController != null &&
            _videoController!.value.isInitialized &&
            !_isVideoLoading) {
          final position = _videoController!.value.position.inMilliseconds;
          final duration =
              _videoController!.value.duration?.inMilliseconds ?? 0;

          if (duration > 0) {
            _progress = position / duration;
          } else {
            _progress = 0.0;
          }
        } else if (_videoController == null) {
          _progress += 0.01; // For image stories
        }

        // Check if progress is complete
        if (_progress >= 1.0) {
          _progress = 0.0; // Reset progress

          int mediaLength;
          if (context.read<StoryViewModel>().isMyProfile) {
            mediaLength =
                context.read<StoryViewModel>().myStoryModel.media!.length;
          } else {
            mediaLength =
                context.read<StoryViewModel>().storyModel.media!.length;
          }

          if (_currentPage < mediaLength - 1) {
            _currentPage++;
            _pageController.animateToPage(
              _currentPage,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
            // if (context.read<StoryViewModel>().isMyProfile) {
            //   context.read<StoryViewModel>().fetchStoryViews(
            //       mediaId: context
            //           .read<StoryViewModel>()
            //           .storyModel
            //           .media![_currentPage]
            //           .sId
            //           .toString(),
            //       storyId: context
            //           .read<StoryViewModel>()
            //           .myStoryModel
            //           .sId
            //           .toString());
            // }
            _initializeVideo();
          } else {
            print("completed");
            // All stories completed, navigate back
            _timer?.cancel();
            Navigator.pop(context);
          }
        }
      });
    });
  }

  void _initializeVideo() {
    _videoController?.dispose();
    if (context.read<StoryViewModel>().isMyProfile) {
      _initializeMyStoryVideo();
    } else {
      _initializeOtherStoryVideo();
    }
  }

  void _initializeMyStoryVideo() {
    final mediaList = context.read<StoryViewModel>().myStoryModel.media;
    if (mediaList != null && mediaList.isNotEmpty) {
      final currentStory = mediaList[_currentPage];
      if (currentStory.mediaType == "video" && currentStory.content != null) {
        _videoController = VideoPlayerController.network(currentStory.content!)
          ..initialize().then((_) {
            setState(() {
              _isVideoLoading = false;
              _videoController!.play();
            });
          }).catchError((_) {
            setState(() {
              _isVideoLoading = false;
              _videoController = null;
            });
          });
      } else {
        _videoController = null;
      }
    }
  }

  void _initializeOtherStoryVideo() {
    final mediaList = context.read<StoryViewModel>().storyModel.media;
    if (mediaList != null && mediaList.isNotEmpty) {
      final currentStory = mediaList[_currentPage];
      if (currentStory.mediaType == "video" && currentStory.content != null) {
        _videoController = VideoPlayerController.network(currentStory.content!)
          ..initialize().then((_) {
            setState(() {
              _isVideoLoading = false;
              _videoController!.play();
            });
          }).catchError((_) {
            setState(() {
              _isVideoLoading = false;
              _videoController = null;
            });
          });
      } else {
        _videoController = null;
      }
    }
  }

  void _goToNextStory(bool isMyProfile) {
    _timer?.cancel();
    final mediaLength = isMyProfile
        ? context.read<StoryViewModel>().myStoryModel.media?.length ?? 0
        : context.read<StoryViewModel>().storyModel.media?.length ?? 0;

    if (_currentPage < mediaLength - 1) {
      setState(() {
        _currentPage++;
        _progress = 0.0;
      });
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _initializeVideo();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StoryViewModel>(builder: (context, value, child) {
        final isMyProfile = value.isMyProfile;
        final mediaList =
            isMyProfile ? value.myStoryModel.media : value.storyModel.media;

        if (mediaList == null || mediaList.isEmpty) {
          return Center(child: Text("No stories available"));
        }

        return Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                    _progress = 0.0;
                  });
                  if (value.isMyProfile) {
                    final mediaId = value.myStoryModel.media![index].sId;
                    value.fetchStoryViews(
                        mediaId: mediaId!,
                        storyId: value.myStoryModel.sId.toString());
                  } else {
                    value.updateStoryView(
                        storyId: value.storyModel.sId.toString(),
                        lastViewedMediaId:
                            value.storyModel.media![index].sId.toString(),
                        context: context);
                  }

                  // _updateViewCount(stories[index]['id']);
                  _initializeVideo();
                },
                itemCount: mediaList.length,
                itemBuilder: (context, index) {
                  final story = mediaList[index];
                  return GestureDetector(
                    // onTap: () => _goToNextStory(isMyProfile),
                    child: story.mediaType == "video"
                        ? (_videoController != null &&
                                _videoController!.value.isInitialized
                            ? VideoPlayer(_videoController!)
                            : Center(child: CircularProgressIndicator()))
                        : (story.mediaType == "image"
                            ? Image.network(story.content!)
                            : Center(child: Text("Invalid"))),
                  );
                },
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  LinearProgressIndicatorUi(
                    currentPage: _currentPage,
                    isVideoLoading: _isVideoLoading,
                    progress: _progress,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: isMyProfile
                            ? (value.myStoryModel.user?.profileImageUrl
                                        ?.isEmpty ??
                                    true
                                ? AssetImage(PImages.profile)
                                : NetworkImage(
                                    value.myStoryModel.user!.profileImageUrl!))
                            : (value.storyModel.userProfileImg?.isEmpty ?? true
                                    ? AssetImage(PImages.profile)
                                    : NetworkImage(
                                        value.storyModel.userProfileImg!))
                                as ImageProvider,
                      ),
                      SizedBox(width: 10),
                      Text(
                        isMyProfile
                            ? value.myStoryModel.user?.name ?? ""
                            : value.storyModel.userName ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            _deleteStory(context);
                          },
                          child: Icon(Icons.delete))
                    ],
                  ),
                ],
              ),
            ),
            if (isMyProfile)
              Positioned(
                bottom: 20,
                left: 120,
                right: 120,
                child: Row(
                  children: [
                    Expanded(child: _storyViewCountWidget()),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _storyViewCountWidget() {
    return Consumer<StoryViewModel>(
      builder: (context, value, child) => GestureDetector(
        onTap: value.storyCount == 0
            ? null
            : () {
                showBottomSheet(
                  context: context,
                  builder: (context) => StoryViewsSheetUi(),
                );
              },
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: PColors.whiteOff.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(PSvgs.eye),
              SizedBox(
                width: 10,
              ),
              Text(
                "${value.storyCount.toString()} Views",
                style: TextStyle(
                    color: PColors.white, fontWeight: FontWeight.w500),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _deleteStory(BuildContext context) async {
    final storyViewModel = context.read<StoryViewModel>();
    final currentStoryId = storyViewModel.myStoryModel.media![_currentPage].sId;

    var success = await storyViewModel.removeStory(
        mediaId: currentStoryId.toString(),
        storyId: context.read<StoryViewModel>().myStoryModel.sId.toString(),
        context: context);

    if (success == true) {
      setState(() {
        storyViewModel.myStoryModel.media!.removeAt(_currentPage);
        if (_currentPage > 0) _currentPage--;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Story deleted successfully")),
      );

      if (storyViewModel.myStoryModel.media!.isEmpty) {
        Navigator.pop(context); // Close viewer if no stories are left
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete story")),
      );
    }
  }
  // void _goToNextStory(bool isMyProfile) {
  //   int mediaLength = isMyProfile
  //       ? context.read<StoryViewModel>().myStoryModel.media!.length
  //       : context.read<StoryViewModel>().storyModel.media!.length;

  //   if (_currentPage < mediaLength - 1) {
  //     setState(() {
  //       _currentPage++;
  //       _progress = 0.0;
  //     });
  //     _pageController.animateToPage(
  //       _currentPage,
  //       duration: Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //     _initializeVideo();
  //   } else {
  //     _timer?.cancel();
  //     Navigator.pop(context); // Exit if it's the last story
  //   }
  // }
}
