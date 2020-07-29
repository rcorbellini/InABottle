
import 'package:geochat/home/home_bloc.dart';
import 'package:geochat/home/home_widget.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoute(SailorRoute(
        name: HomeBloc.route,
        builder: (context, args, params) {
          return HomeWidget();
        },
      ));
  }
}


