import 'package:in_a_bottle/home/home_feed.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/user/user_dto.dart';

class DirectMessage extends HomeFeed {
  final String selector;
  final String text;
  final String title;
  final User owner;
  final Local local;

  DirectMessage({this.selector, this.text, this.title, this.owner, this.local});
}
