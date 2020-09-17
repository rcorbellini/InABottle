import 'package:flutter/material.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:in_a_bottle/user/user.dart';

extension Avatars on CircleAvatar {
  //um dia irá de existir no dart (tenha fé)
  //factory/static extesions
  static CircleAvatar big(String url) {
    return CircleAvatar(
      radius: 30,
      //mock da imagem
      child: ClipOval(
          child: Image.network(
              url ??
                  "https://lh3.googleusercontent.com/a-/AOh14GjcZr7Td-GC9joDcnbnimnc41KvfAgQ9oVrBFYj=s96-c-rg-br100",
              fit: BoxFit.scaleDown)),
    );
  }

  static CircleAvatar small(String url) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.black,
      child: ClipOval(
          child: Image.network(
              url ??
                  "https://lh3.googleusercontent.com/a-/AOh14GjcZr7Td-GC9joDcnbnimnc41KvfAgQ9oVrBFYj=s96-c-rg-br100",
              fit: BoxFit.scaleDown)),
    );
  }
}

extension Cards on Card {
  //um dia irá de existir no dart (tenha fé)
  //factory/static extesions

  static Card base(
      {@required Widget child,
      @required GestureTapCallback onTap,
      @required double height,
      @required double width,
      EdgeInsetsGeometry padding = const EdgeInsets.all(16)}) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        elevation: 0.5,
        child: GestureDetector(
            onTap: onTap,
            child: Container(
                height: height, padding: padding, width: width, child: child)));
  }

  static Card timeLine({
    @required Widget child,
    @required GestureTapCallback onTap,
  }) {
    return base(
        child: child, onTap: onTap, height: 120, width: double.infinity);
  }

  static Card treasureHunt(
      {@required Widget child,
      @required GestureTapCallback onTap,
      @required double width,
      EdgeInsetsGeometry padding}) {
    return base(
        child: child,
        onTap: onTap,
        height: 400,
        width: width,
        padding: padding);
  }

  static Card talks(
      {@required Widget child,
      @required GestureTapCallback onTap,
      double width = double.infinity,
      EdgeInsetsGeometry padding}) {
    return base(
        child: child,
        onTap: onTap,
        height: 300,
        width: width,
        padding: padding);
  }
}

///build deixar dinamico
///os parametros de posicao
class FlagsOverflow extends StatelessWidget {
  final Widget iconflag;
  final Widget contentFlag;
  final Color background;

  const FlagsOverflow(
      {Key key, this.iconflag, this.contentFlag, this.background})
      : super(key: key);

  FlagsOverflow.lock()
      : iconflag = Icon(
          Icons.lock,
          color: Colors.white,
        ),
        contentFlag = Container(),
        background = Colors.grey[800];

  FlagsOverflow.treasureHunt(BuildContext context, String content)
      : iconflag = Icon(
          Icons.map,
          color: Colors.white,
        ),
        contentFlag = Text(
          content,
          style: Theme.of(context)
              .textTheme
              .overline
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        background = Colors.brown[800];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: 30.0,
            height: 90.0,
            color: background,
            padding: EdgeInsets.only(bottom: 10),
            child: Center(child: contentFlag),
          ),
          Positioned(bottom: 20, left: 3, child: iconflag),
          Positioned(
              bottom: -20,
              left: -5,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}

class AvatarsReactions extends StatelessWidget {
  final List<UserReaction> reactions;

  const AvatarsReactions({Key key, this.reactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reactions?.isEmpty ?? true) {
      return Container(width: 60);
    }
    return Container(
        width: 100,
        padding: EdgeInsets.only(left: 8),
        child: Stack(
            overflow: Overflow.clip,
            children: reactions
                .asMap()
                .map((key, value) => MapEntry(
                    key,
                    key == 0
                        ? Avatars.small(value.createdBy?.photoUrl)
                        : Positioned(
                            left: key * 10.0,
                            child: Avatars.small(value.createdBy?.photoUrl))))
                .values
                .toList()));
  }
}

class AvatarTimeLine extends StatelessWidget {
  final User user;
  const AvatarTimeLine({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
            margin: EdgeInsets.all(3.0),
            height: 60.0,
            width: 60.0,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Avatars.big(user?.photoUrl),
                Positioned(
                  bottom: -10,
                  right: -5,
                  child: Coin(points: user?.points),
                )
              ],
            )));
  }
}

class Coin extends StatelessWidget {
  final int points;
  final double height;
  final double width;

  const Coin({Key key, this.points, this.width = 35, this.height = 35})
      : super(key: key);

  Coin.small(int points)
      : this.points = points,
        this.width = 25,
        this.height = 25;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Stack(alignment: Alignment.center, children: [
          Image.asset(
            "assets/images/coin.png",
          ),
          Text(
            points?.toString() ?? "1k",
            style: Theme.of(context)
                .textTheme
                .overline
                .copyWith(fontWeight: FontWeight.bold),
          )
        ]),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.amber.withOpacity(0.95),
          border: Border.all(color: Colors.white, width: 3)),
    );
  }
}
