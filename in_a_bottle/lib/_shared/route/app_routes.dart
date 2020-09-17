import 'package:flutter/material.dart';
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
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/message_treasure_widget.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/message_treasure_bloc.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/treasure_hunt_bloc.dart';
import 'package:in_a_bottle/local_message/treasure_hunt/widget/create/treasure_hunt_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeBloc.route:
      return MaterialPageRoute(builder: (context) => HomeWidget());
    case DirectMessageBloc.route:
      return MaterialPageRoute(builder: (context) => DirectMessageWidget());
    case TalkBloc.route:
      return MaterialPageRoute(builder: (context) => TalkWidget());

    case CreateHubMessageBloc.route:
      return MaterialPageRoute(builder: (context) => CreateHubMessageWidget());

    case TreasureHuntBloc.route:
      return MaterialPageRoute(builder: (context) => TreasureHuntWidget());

    case MessageTreasureBloc.route:
      return MaterialPageRoute(builder: (context) => MessageTreasureWidget());

    case InteractDirectMessageBloc.route:
      return CupertinoModalBottomSheetRoute(
          settings: settings,
          expanded: false, 
          builder: (context,scrollController) => InteractDirectMessageWidget(
              selector:
                  (settings.arguments as Map<String, dynamic>)["selector"]));

    case InteractHubMessageBloc.route:
      return CupertinoModalBottomSheetRoute(
          settings: settings,
          expanded: true,
          builder: (context, scrollController) => InteractHubMessageWidget(
              selector:
                  (settings.arguments as Map<String, dynamic>)["selector"]));

    case InteractTalkBloc.route:
      return CupertinoModalBottomSheetRoute(
          expanded: true,
        settings: settings,
        builder: (context, scrollController) => InteractTalkWidget(
            selector: (settings.arguments as Map<String, dynamic>)["selector"]),
      );

    default:
      return null;
  }
}
