import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class ReactionWidget extends StatelessWidget {
  final OnReactionChange onReactionChange;
  final Set<UserReaction> userReactions;

  const ReactionWidget({Key key, this.onReactionChange, this.userReactions})
      : super(key: key);

  //TODO remover daqui e fazer descente
  static final List<TypeReaction> allTypeReactions = [
    const TypeReaction(
      selector: 'heart',
      url: ':heart:',
      urlPreview: ':heart:',
    ),
    const TypeReaction(
      selector: 'thumbs',
      url: ':+1:',
      urlPreview: ':+1:',
    ),
    const TypeReaction(
      selector: 'olhos',
      url: ':eyes:',
      urlPreview: ':eyes:',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final Set<UserReaction> reactions = userReactions ?? <UserReaction>{};
    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          ...reactions
              .map<Widget>((UserReaction ur) => _buildReaction(ur.reaction))
              .toList(),
          FlutterReactionButton(
            onReactionChanged: (reaction, _) {
              final reactionX = reaction as ReactionX;
              onReactionChange?.call(reactionX.typeReaction);
            },
            shouldChangeReaction: false,
            boxColor: Colors.black,
            boxRadius: 0,
            reactions: allTypeReactions
                .map((e) => ReactionX(
                      typeReaction: e,
                      id: 1,
                      previewIcon: _buildPreviewIcon(e.urlPreview),
                      icon: _buildIcon(e.url),
                    ))
                .toList(),
            initialReaction: ReactionX(
                id: 0,
                icon: Container(
                    height: 45,
                    padding: EdgeInsets.only(left: 4),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[800],
                      ),
                      child: Center(
                          child: Icon(
                        Icons.insert_emoticon,
                        color: Colors.white,
                      )),
                    ))),
          )
        ]));
  }

  //https://pub.dev/packages/flutter_reaction_button
  Widget _buildReaction(TypeReaction reaction) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Row(children: [
        GestureDetector(
          onTap: () => onReactionChange?.call(reaction),
          child: _buildIcon(reaction.url),
        ),
        Text(reaction?.amount?.toString()??"0", style: TextStyle(fontWeight: FontWeight.bold),),
      ]),
    );
  }

  Widget _buildIcon(String imageUrl) =>   Padding(
    
        padding: EdgeInsets.all(6),
  child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
        child: Center(child: Text(EmojiParser().emojify(imageUrl))),
      )
  );

  //Image.network(
  //      imageUrl,
  //      height: 30,
  //     width: 30,
  //  );

  Widget _buildPreviewIcon(String imageUrl) => Padding(
      padding: EdgeInsets.all(6),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[800],
        ),
        child: Center(child: Text(EmojiParser().emojify(imageUrl))),
      ));

  //Padding(
  //      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //      child: Image.network(imageUrl, height: 30),
  //    );
}

typedef OnReactionChange = void Function(TypeReaction);

class ReactionX extends Reaction {
  final TypeReaction typeReaction;

  ReactionX(
      {this.typeReaction,
      int id,
      Widget icon,
      Widget previewIcon,
      bool enabled = true})
      : super(id: id, icon: icon, previewIcon: previewIcon, enabled: enabled);
}
