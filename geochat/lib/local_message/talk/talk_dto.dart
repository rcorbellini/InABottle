import 'package:geochat/local_message/talk/message_talk_dto.dart';
import 'package:geochat/local_message/talk/talk_category_dto.dart';

class Talk {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final List<MessageTalk> open;
  final List<MessageTalk> close;
  final TalkCategory mainCategory;
  final List<TalkCategory> categories;
  final int usersCount;

  Talk(
      {this.title,
      this.startDate,
      this.endDate,
      this.open,
      this.close,
      this.usersCount,
      this.categories,
      this.mainCategory});
}
