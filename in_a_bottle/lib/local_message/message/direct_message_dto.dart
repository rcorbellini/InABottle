import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class DirectMessage implements HomeFeed {
  final String text;
  final String title;
  final User owner;
  final Local local;

  DirectMessage({this.text, this.title, this.owner, this.local});

  DirectMessage.fromMap(Map<String, dynamic> map)
      : text = map["text"]?.toString(),
        title = map["title"]?.toString(),
        owner = null,
        local = null;
}
