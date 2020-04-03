import 'package:flutter/material.dart';

import '../models/story.dart';
import './story_item.dart';

class StoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: loadedStory.length,
      itemBuilder: (ctx, i){
        return StoryItem(sIid: loadedStory[i].id,

          sIstoryTitle: loadedStory[i].storyTitle,
          sIstorySubTitle: loadedStory[i].storySubTitle,
          sIstoryContent: loadedStory[i].storyContent,
          sIstoryTime: loadedStory[i].storyTime,
          sIimageURL: loadedStory[i].imageURL,
        );
      },
    );
  }
}
