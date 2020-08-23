import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:in_a_bottle/local_message/talk/talk_message.dart';
import 'package:in_a_bottle/local_message/talk/talk_category_dto.dart';

class Talk {
  final String title;
  final String descrition;
  final DateTime startDate;
  final DateTime endDate;
  final List<TalkMessage> open;
  final List<TalkMessage> close;
  final TalkCategory mainCategory;
  final List<TalkCategory> categories;
  final int usersCount;
  final Local local;

  Talk(
      {this.title,
      this.descrition,
      this.startDate,
      this.endDate,
      this.open,
      this.close,
      this.usersCount,
      this.categories,
      this.mainCategory,
      this.local});
}
