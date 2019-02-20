import 'package:flutter/material.dart';
import 'login_bloc.dart';

class Provider extends InheritedWidget {
  Provider({Key key, this.child}) : super(key: key, child: child);

  final Widget child;
  final LoginBloc loginBloc =LoginBloc();

  static Provider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider)as Provider);
  }

  @override
  bool updateShouldNotify( Provider oldWidget) {
    return true;
  }
}
