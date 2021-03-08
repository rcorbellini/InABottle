import 'package:flutter/material.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/bloc/home_bloc.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/home/pages/widgets/home_widget.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/treasure_hunt/bloc/treasure_hunt_bloc.dart';
import 'package:in_a_bottle/features/treasure_hunt/presentation/treasure_hunt/pages/treasure_hunt_widget.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeBloc.route:
      return MaterialPageRoute(builder: (context) => HomeWidget());

    case TreasureHuntBloc.route:
      return MaterialPageRoute(builder: (context) => TreasureHuntWidget());


  /*
    case DirectMessageBloc.route:
      return MaterialPageRoute(builder: (context) => DirectMessageWidget());
    case TalkBloc.route:
      return MaterialPageRoute(builder: (context) => TalkWidget());

    case CreateHubMessageBloc.route:
      return MaterialPageRoute(builder: (context) => CreateHubMessageWidget());

    case MessageTreasureBloc.route:
      return MaterialPageRoute(builder: (context) => MessageTreasureWidget());

    case InteractDirectMessageBloc.route:
      return CupertinoModalBottomSheetRoute(
          settings: settings,
          expanded: false,
          builder: (context, scrollController) => InteractDirectMessageWidget(
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
*/
    default:
       throw Exception("Toute not found");
  }
}
