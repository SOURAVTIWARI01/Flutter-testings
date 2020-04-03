import 'package:flutter/foundation.dart';


class FtStory {
  final String id;

  final String storyTitle ;
  final String storySubTitle;
  final String storyContent;
  bool isStar;
  final String storyTime;
  final String imageURL;

  FtStory(
      { @required this.id,

        @required this.storyTitle,
        @required this.storySubTitle,
        @required this.storyContent,
        this.isStar = false,
        @required this.storyTime,
        @required this.imageURL

      });
}