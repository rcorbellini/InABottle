import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:in_a_bottle/local_message/reaction/type_reaction.dart';
import 'package:in_a_bottle/local_message/reaction/user_reaction.dart';

class ReactionWidget extends StatelessWidget {
  final OnReactionChange onReactionChange;
  final Set<UserReaction> userReactions;

  const ReactionWidget({Key key, this.onReactionChange, this.userReactions})
      : super(key: key);

  //TODO remover daqui e fazer descente
  static final List<TypeReaction> allTypeReactions = [
    const TypeReaction(
      selector: 'corbellini-1',
      url:
          'https://lh3.google.com/u/1/ogw/ADGmqu8Cu89HRnDTSL2_XKXABmwoeL038BTA7_DPVDbs=s32-c-mo',
      urlPreview:
          'https://lh3.google.com/u/1/ogw/ADGmqu8Cu89HRnDTSL2_XKXABmwoeL038BTA7_DPVDbs=s32-c-mo',
    ),
    const TypeReaction(
      selector: 'corbellini-2',
      url:
          'https://lh3.googleusercontent.com/ogw/ADGmqu_0MXQKJj2LcjUSpFdxeshwTYbTLj8Ud705WzKC=s83-c-mo',
      urlPreview:
          'https://lh3.googleusercontent.com/ogw/ADGmqu_0MXQKJj2LcjUSpFdxeshwTYbTLj8Ud705WzKC=s83-c-mo',
    ),
    const TypeReaction(
      selector: 'corbellini-3',
      url:
          'https://lh3.google.com/u/2/ogw/ADGmqu8j08OCxlZTqkNOO2m8DSwmLgUGzfd6UlENNrt0=s32-c-mo',
      urlPreview:
          'https://lh3.google.com/u/2/ogw/ADGmqu8j08OCxlZTqkNOO2m8DSwmLgUGzfd6UlENNrt0=s32-c-mo',
    )
  ];

  @override
  Widget build(BuildContext context) {
    final Set<UserReaction> reactions  = userReactions ?? <UserReaction>{};
    return Container(
        child: Column(children: [
      ...reactions
          .map<Widget>((UserReaction ur) => _buildReaction(ur.reaction))
          .toList(),
      FlutterReactionButton(
        onReactionChanged: (reaction) {
          final reactionX = reaction as ReactionX;
          onReactionChange?.call(reactionX.typeReaction);
        },
        shouldChangeReaction: false,
        boxColor: Colors.black,
        reactions: allTypeReactions
            .map((e) => ReactionX(
                  typeReaction: e,
                  id: 1,
                  previewIcon: _buildPreviewIcon(e.urlPreview),
                  icon: _buildIcon(e.url),
                ))
            .toList(),
        initialReaction: ReactionX(id: 0, icon: const Icon(Icons.add)),
      )
    ]));
  }

  //https://pub.dev/packages/flutter_reaction_button
  Widget _buildReaction(TypeReaction reaction) {
    return Column(children: [
      GestureDetector(
        onTap: () => onReactionChange?.call(reaction),
        child: _buildIcon(reaction.url),
      ),
      Text(reaction.amount.toString()),
    ]);
  }

  Widget _buildIcon(String imageUrl) => Image.network(
        imageUrl,
        height: 30,
        width: 30,
      );

  Widget _buildPreviewIcon(String imageUrl) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Image.network(imageUrl, height: 30),
      );
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
