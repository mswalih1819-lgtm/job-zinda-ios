import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/api_url.dart';

/// Widget to display admin document inline (image/video preview) or as a download button for other file types.
class AdminDocWidget extends StatefulWidget {
  final String url;
  final double? height;
  final double? width;
  const AdminDocWidget({Key? key, required this.url, this.height, this.width}) : super(key: key);

  @override
  State<AdminDocWidget> createState() => _AdminDocWidgetState();
}

class _AdminDocWidgetState extends State<AdminDocWidget> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  bool _isImage = false;

  @override
  void initState() {
    super.initState();
    final url = widget.url.toLowerCase();
    _isVideo = url.endsWith('.mp4') || url.contains('video');
    _isImage = url.endsWith('.jpg') || url.endsWith('.jpeg') || url.endsWith('.png') || url.endsWith('.gif');
    if (_isVideo) {
      _controller = VideoPlayerController.network(widget.url)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isImage) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: widget.url,
            height: widget.height,
            width: widget.width,
            fit: BoxFit.cover,
            placeholder: (ctx, _) => const Center(child: CircularProgressIndicator()),
            errorWidget: (ctx, _, __) => const Icon(Icons.broken_image),
          ),
          _downloadButton(context),
        ],
      );
    } else if (_isVideo && _controller != null && _controller!.value.isInitialized) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller!),
                if (!_controller!.value.isPlaying)
                  IconButton(
                    icon: const Icon(Icons.play_circle, size: 48, color: Colors.white),
                    onPressed: () => setState(() => _controller!.play()),
                  ),
              ],
            ),
          ),
          _downloadButton(context),
        ],
      );
    } else {
      // For other file types, show only download button
      return _downloadButton(context);
    }
  }

  Widget _downloadButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: OutlinedButton.icon(
        icon: const Icon(Icons.download),
        label: const Text('Download'),
        onPressed: () async {
          final s3Url = widget.url;
          if (await canLaunchUrl(Uri.parse(s3Url))) {
            await launchUrl(Uri.parse(s3Url), mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Could not launch download URL')),
            );
          }
        },
      ),
    );
  }
}
