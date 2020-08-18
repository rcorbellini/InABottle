import 'package:flutter/material.dart';
import 'package:in_a_bottle/_shared/archtecture/base_bloc.dart';
import 'package:in_a_bottle/_shared/injection/injector.dart';
import 'package:in_a_bottle/_shared/localization/localization.dart';
import 'package:in_a_bottle/_shared/widgets/message_handler.dart';
import 'package:in_a_bottle/_shared/widgets/widget_factory/form_factory.dart';
import 'package:fancy_stream/fancy_stream.dart';

class CrudWidget<FORM, ERROR, BLOC extends BaseBloc<FORM>>
    extends StatefulWidget {
  final CrudBuilder builder;
  final Initilizer initlizer;

  const CrudWidget({Key key, this.builder, this.initlizer}) : super(key: key);
  @override
  _CrudWidgetState<FORM, ERROR, BLOC> createState() => _CrudWidgetState();
}

class _CrudWidgetState<FORM, ERROR, BLOC extends BaseBloc<FORM>>
    extends State<CrudWidget> {
  BLOC _bloc;
  FormFactory _factory;
  MessageHandler _messageHandler;

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
    final title = AppLocalizations.of(context).translate("Shared.errorTitle");

    _messageHandler.showError(errors: errors, title: title, context: context);
  }
}

typedef CrudBuilder = Widget Function(
    BaseBloc bloc, FormFactory wfactory);

typedef Initilizer = void Function(
    BaseBloc bloc, FormFactory wfactory);
