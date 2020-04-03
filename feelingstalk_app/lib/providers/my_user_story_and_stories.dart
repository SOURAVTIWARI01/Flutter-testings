import 'package:flutter/foundation.dart';

class UserStoryItem {
  final String id;
  final String storyTitle;
  final String storySubTitle;
  final String storyContent;
  bool isStar;
  bool isBookmarked;
  final String storyTime;
  final String imageURL;

  UserStoryItem(
      {@required this.id,
      @required this.storyTitle,
      this.storySubTitle,
      @required this.storyContent,
      this.isStar = false,
      this.isBookmarked = false,
      @required this.storyTime,
      @required this.imageURL});
}

class UserStory with ChangeNotifier {
  Map<String, UserStoryItem> _items;

  Map<String, UserStoryItem> get items {
    return {..._items};
  }

  void addItem(
    String id,
    final String storyTitle,
    final String storySubTitle,
    final String storyContent,
    bool isStar,
    bool isBookmarked,
    final String storyTime,
    final String imageURL,
  ) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingItem) => UserStoryItem(
          id: existingItem.id,
          storyTitle: existingItem.storyTitle,
          storySubTitle: existingItem.storySubTitle,
          storyContent: existingItem.storyContent,
          isStar: existingItem.isStar,
          isBookmarked: existingItem.isBookmarked,
          storyTime: existingItem.storyTime,
          imageURL: existingItem.imageURL,
        ),
      );
    } else {
      _items.putIfAbsent(
          id,
          () => UserStoryItem(
                id: id,
                storyTitle: storyTitle,
                storySubTitle: storySubTitle.isEmpty ? '' : storySubTitle,
                storyContent: storyContent,
                isStar: isStar,
                isBookmarked: isBookmarked,
                storyTime: storyTime,
                imageURL: imageURL,
              ));
    }
  }
}
