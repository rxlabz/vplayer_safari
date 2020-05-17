import 'package:flutter/material.dart';

import 'web_video_player.dart';

class VideoView extends StatelessWidget {
  final String videoUrl;
  final bool autoplay;
  final VoidCallback onComplete;

  const VideoView({
    Key key,
    this.videoUrl,
    this.autoplay = true,
    this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: WebVideoWidget(
              width: constraints.maxWidth.toInt(),
              height: constraints.maxHeight.toInt(),
              autoplay: autoplay,
              src: '$videoUrl',
              onComplete: onComplete,
              showControls: true,
            ),
          ),
        ),
      );
}
