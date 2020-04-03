import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_input__textfield_screen.dart';


import '../providers/stories.dart';
import '../providers/story.dart';

class UserStoryList extends StatelessWidget {
  final String id;
  final String storyTitle;
  final String storySubTitle;
  final String storyContent;
  bool isStar;
  bool isBookmarked;
  final String storyTime;
  final String imageURL;
  void toggleStarStatus() {
    isStar = !isStar;
  }

  void toggleBookmarkedStatus() {
    isBookmarked = !isBookmarked;
  }

  UserStoryList(
      {@required this.id,
        @required this.storyTitle,
        this.storySubTitle,
        @required this.storyContent,
        this.isStar = false,
        this.isBookmarked = false,
        @required this.storyTime,
        @required this.imageURL});


  @override
  Widget build(BuildContext context) {
    final getStory= Provider.of<FtStory>(context);
  //  final getStories= Provider.of<Stories>(context);
    return Container(
      child: Card(
        elevation: 5,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        borderOnForeground: true,
        color: Color(0xfff6f6f6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  child: Image.asset(
                    'assets/my.jpg',
                  ),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.red,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      storyTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      storySubTitle== null ?'' : storySubTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      storyTime,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        imageURL,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      storyContent,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    getStory.isStar ? Icons.star : Icons.star_border,
                  ),
                  onPressed: () {
                    getStory.toggleStarStatus();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.insert_comment,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    getStory. isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    getStory.toggleBookmarkedStatus();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.teal,
                  ),
                  onPressed: () {

                    Navigator.of(context).pushNamed(AddInputTextFieldScreen.routeName, arguments: id
                    );

                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Provider.of<Stories>(context).deleteStories(id);

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



