import 'package:flutter/material.dart';

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
                height: height,
                padding: padding,
                width: width,
                child: child)));
  }

  static Card timeLine({
    @required Widget child,
    @required GestureTapCallback onTap,
  }) {
    return base(
        child: child, onTap: onTap, height: 120, width: double.infinity);
  }

  static Card treasureHunt({
    @required Widget child,
    @required GestureTapCallback onTap,
    @required double width,
    EdgeInsetsGeometry padding
  }) {
    return base(child: child, onTap: onTap, height: 200, width: width, padding:padding);
  }

  static Card talks({
    @required Widget child,
    @required GestureTapCallback onTap,
    @required double width,
  }) {
    return base(child: child, onTap: onTap, height: 400, width: width);
  }
}
