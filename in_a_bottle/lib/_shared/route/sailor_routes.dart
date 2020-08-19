import 'package:in_a_bottle/_shared/route/sailor_navigator.dart';
import 'package:in_a_bottle/home/home_bloc.dart';
import 'package:in_a_bottle/home/widgets/home_widget.dart';
import 'package:in_a_bottle/local_message/chat/create/create_chat_bloc.dart';
import 'package:in_a_bottle/local_message/chat/create/create_chat_widget.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_chat_bloc.dart';
import 'package:in_a_bottle/local_message/chat/interact/interact_chat_widget.dart';
import 'package:in_a_bottle/local_message/message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/message/widgets/create/direct_message_widget.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_widget.dart';
import 'package:sailor/sailor.dart';

class SailorRoutes {
  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: HomeBloc.route,
      builder: (context, args, params) {
        return HomeWidget();
      },
    ));
    sailor.addRoute(SailorRoute(
      name: DirectMessageBloc.route,
      builder: (context, args, params) {
        return DirectMessageWidget();
      },
    ));

    sailor.addRoute(SailorRoute(
      name: TalkBloc.route,
      builder: (context, args, params) {
        return TalkWidget();
      },
    ));
    sailor.addRoute(SailorRoute(
      name: CreateChatBloc.route,
      builder: (context, args, params) {
        return CreateChatWidget();
      },
    ));

    sailor.addRoute(SailorRoute(
        name: InteractChatBloc.route,
        builder: (context, args, params) {
          return InteractChatWidget(
            selector: params.param<String>('selector'),
          );
        },
        params: [
          SailorParam<String>(
            name: 'selector',
            defaultValue: null,
          ),
        ]));
  }
}
