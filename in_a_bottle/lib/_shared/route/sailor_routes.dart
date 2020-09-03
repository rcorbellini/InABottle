import 'package:in_a_bottle/_shared/route/sailor_navigator.dart';
import 'package:in_a_bottle/home/widgets/home_bloc.dart';
import 'package:in_a_bottle/home/widgets/home_widget.dart';
import 'package:in_a_bottle/local_message/hub/create/create_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/create/create_hub_message_widget.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_bloc.dart';
import 'package:in_a_bottle/local_message/hub/interact/interact_hub_message_widget.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_widget.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/interact/interact_direct_message_widget.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/create/talk_widget.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_bloc.dart';
import 'package:in_a_bottle/local_message/talk/widget/interact/interact_talk_widget.dart';
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
      name: CreateHubMessageBloc.route,
      builder: (context, args, params) {
        return CreateHubMessageWidget();
      },
    ));

    sailor.addRoute(SailorRoute(
        name: InteractDirectMessageBloc.route,
        builder: (context, args, params) {
          return InteractDirectMessageWidget(
            selector: params.param<String>('selector'),
          );
        },
        params: [
          SailorParam<String>(
            name: 'selector',
            defaultValue: null,
          ),
        ]));

    sailor.addRoute(SailorRoute(
        name: InteractHubMessageBloc.route,
        builder: (context, args, params) {
          return InteractHubMessageWidget(
            selector: params.param<String>('selector'),
          );
        },
        params: [
          SailorParam<String>(
            name: 'selector',
            defaultValue: null,
          ),
        ]));

    sailor.addRoute(SailorRoute(
        name: InteractTalkBloc.route,
        builder: (context, args, params) {
          return InteractTalkWidget(
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
