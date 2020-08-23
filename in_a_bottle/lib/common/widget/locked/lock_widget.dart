import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/crud_widget.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/form_factory.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/widget_text_field.dart';
import 'package:in_a_bottle/common/widget/locked/lock_bloc.dart';
import 'package:in_a_bottle/local_message/local/local_dto.dart';
import 'package:fancy_stream/fancy_stream.dart';

class LockWidget extends StatefulWidget {
  final Local local;
  final Widget child;

  const LockWidget({Key key, this.local, this.child}) : super(key: key);

  @override
  _LockWidgetState createState() => _LockWidgetState();
}

class _LockWidgetState extends State<LockWidget> {
  @override
  Widget build(BuildContext context) { 
    if(widget.local == null){
      return Container();
    }
    return CrudWidget<LockForm, LockErro, LockBloc>(
      initlizer: (_bloc, _factory) {
        _bloc.dispatchOn(widget.local, key: LockForm.local);
      },
      builder: (_bloc, _factory) {
        return StreamBuilder<Local>(
          stream: _bloc.streamOf(key: LockForm.local),
          builder: (context, snpashot) { 
            if (!snpashot.hasData) {
              return Container();
            }
            final local = snpashot.data;
            if (local.isLocked) {
              return _buildLock(_factory);
            }

            return widget.child;
          },
        );
      },
    );
  }

  Widget _buildLock(FormFactory formFactory) {
    return Container(
      child: Column(
        children: [
          formFactory.build(LockForm.textPassword,
              parameters: <TextFieldParameter, dynamic>{
                TextFieldParameter.obscureText: true
              }),
          formFactory.build(LockForm.actionSave)
        ],
      ),
    );
  }
}