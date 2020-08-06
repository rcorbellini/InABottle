import 'package:geochat/home/home_feed.dart';
import 'package:geochat/local_message/local/local_dto.dart';
import 'package:geochat/user/user_dto.dart';

class DirectMessage implements HomeFeed{
  final String text;
  final String title;
  final User owner;
  final Local local;   

  DirectMessage({this.text, this.title, this.owner, this.local});
}