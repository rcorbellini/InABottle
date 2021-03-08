import 'package:chameleon_resolver/chameleon_resolver.dart';
import 'package:fancy_factory/fancy_factory.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart';
import 'package:in_a_bottle/adapters//archtecture/base_bloc.dart';
import 'package:in_a_bottle/adapters//injection/injector.dart';
import 'package:in_a_bottle/adapters//widgets/message_handler.dart';

class CrudWidget<FORM, ERROR extends Object, BLOC extends BaseBloc<FORM>>
    extends StatefulWidget {
  final CrudBuilder builder;
  final Initilizer? initlizer;

  const CrudWidget({Key? key,  required this.builder, this.initlizer}) : super(key: key);

  @override
  _CrudWidgetState<FORM, ERROR, BLOC> createState() => _CrudWidgetState();
}

class _CrudWidgetState<FORM, ERROR, BLOC extends BaseBloc<FORM>>
    extends State<CrudWidget> {
  late BLOC _bloc;
  late FormFactory _factory;
  late MessageHandler _messageHandler;

  @override
  void initState() {
    _bloc = Injector().get();
    _bloc.listenOn<List<ERROR>>(_onError);
    _messageHandler = Injector().get();
    _factory = FormFactory<FORM>(bloc: _bloc, context: context);
    widget.initlizer?.call(_bloc, _factory);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.builder(_bloc, _factory));
  }

  void _onError(List<ERROR> errors) {
    final title =
        ChamaleonLocalizations.of(context).translate("shared.errorTitle");

    _messageHandler.showError(errors: errors, title: title, context: context);
  }
}

typedef CrudBuilder = Widget Function(BaseBloc bloc, FormFactory wfactory);

typedef Initilizer = void Function(BaseBloc bloc, FormFactory wfactory);
