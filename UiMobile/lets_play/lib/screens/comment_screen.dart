import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_play/model/comment.dart';
import 'package:lets_play/model/user.dart';
import "dart:async";

import 'package:lets_play/services/comment_service.dart';
import 'package:lets_play/widgets/progress_indicator.dart';

class CommentScreen extends StatefulWidget {
  final int postId;
  final User postUserOwner;
  final String postMediaUrl;

  const CommentScreen({this.postId, this.postUserOwner, this.postMediaUrl});

  @override
  _CommentScreenState createState() => _CommentScreenState(
      postId: this.postId,
      postOwner: this.postUserOwner,
      postMediaUrl: this.postMediaUrl);
}

class _CommentScreenState extends State<CommentScreen> {
  final int postId;
  final User postOwner;
  final String postMediaUrl;
  List<Comment> _comments;

  final TextEditingController _commentController = TextEditingController();

  _CommentScreenState({this.postId, this.postOwner, this.postMediaUrl});

  @override
  void initState() {
    setState(() {
      getComments();
    });
    super.initState();
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = await CommentService.getComments();

    if (comments != null) {
      setState(() {
        _comments = comments;
      });
    }
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
        ),
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        Divider(),
        ListTile(
          title: TextFormField(
            controller: _commentController,
            decoration: InputDecoration(labelText: 'Write a comment...'),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlineButton(
            onPressed: () {
              addComment(_commentController.text);
            },
            borderSide: BorderSide.none,
            child: Text("Post"),
          ),
        ),
      ],
    );
  }

  Widget buildComments() {
    if (_comments == null) {
      getComments();
      return Column(
        children: <Widget>[
          Text(
            'No events comments yet!',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              )),
        ],
      );
    } else {
      return ListView(
          children: _comments
              .where((element) => element.eventId == postId)
              .map((data) => CommentWidget(comment: data))
              .toList());
    }
  }

  addComment(String comment) {
    _commentController.clear();
    Comment newComment = Comment(eventId: postId, id: widget.postUserOwner.uid,message: comment );
    setState(() {
      _comments.add(newComment);
    });
    CommentService.addComment(newComment);
//    Firestore.instance
//        .collection("insta_comments")
//        .document(postId)
//        .collection("comments")
//        .add({
//      "username": currentUserModel.username,
//      "comment": comment,
//      "timestamp": DateTime.now(),
//      "avatarUrl": currentUserModel.photoUrl,
//      "userId": currentUserModel.id
//    });
//
//    //adds to postOwner's activity feed
//    Firestore.instance
//        .collection("insta_a_feed")
//        .document(postOwner)
//        .collection("items")
//        .add({
//      "username": currentUserModel.username,
//      "userId": currentUserModel.id,
//      "type": "comment",
//      "userProfileImg": currentUserModel.photoUrl,
//      "commentData": comment,
//      "timestamp": DateTime.now(),
//      "postId": postId,
//      "mediaUrl": postMediaUrl,
//    });
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  CommentWidget({
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text(comment.message),
          leading: ClipOval(
            child: Image.asset(
              'assets/images/profile_image.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
