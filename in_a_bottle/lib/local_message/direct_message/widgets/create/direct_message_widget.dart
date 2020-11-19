import 'package:fancy_factory/fancy_factory.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/common/widget/crud_widget.dart';
import 'package:in_a_bottle/local_message/direct_message/widgets/create/direct_message_bloc.dart';
import 'package:fancy_stream/fancy_stream.dart';

class DirectMessageWidget extends StatefulWidget {
  @override
  _DirectMessageWidgetState createState() => _DirectMessageWidgetState();
}

class _DirectMessageWidgetState extends State<DirectMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Direct Message"),
      ),
      body: SafeArea(child:
          CrudWidget<DirectMessageForm, DirectMessageError, DirectMessageBloc>(
        builder: (_bloc, _factory) {
          return Container(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    child: Text("Direct Message, "),
                  ),
                  _factory.build(DirectMessageForm.textTitle),
                  _factory.build(DirectMessageForm.textContent),
                  _factory.build(DirectMessageForm.boolPrivate),
                  StreamBuilder<bool>(
                      stream:
                          _bloc.streamOf(key: DirectMessageForm.boolPrivate),
                      builder: (date, snapshot) {
                        final _switcherState = snapshot.data ?? false;
                        if (!_switcherState) {
                          return Container();
                        }

                        return _factory.build(DirectMessageForm.textPassword,
                            parameters: <TextFieldParameter, dynamic>{
                              TextFieldParameter.obscureText: true
                            });
                      }),
                  _factory.build(DirectMessageForm.sliderReach),
                  _factory.build(DirectMessageForm.tags),
                  _factory.build(DirectMessageForm.actionSave)
                ])),
              ));
        },
      )),
    );
  }
}
