import 'package:in_a_bottle/_shared/route/sailor_navigator.dart';
import 'package:in_a_bottle/home/home_bloc.dart';
import 'package:in_a_bottle/home/widgets/home_widget.dart';
import 'package:in_a_bottle/local_message/message/direct_message_bloc.dart';
import 'package:in_a_bottle/local_message/message/widgets/direct_message_widget.dart';
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
  }
}
