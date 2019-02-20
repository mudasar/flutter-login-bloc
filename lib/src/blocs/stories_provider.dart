import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/stories_bloc.dart';

class StoriesProvider extends InheritedWidget {

  final StoriesBloc bloc;

  StoriesProvider({Key key, Widget child}) :bloc = StoriesBloc (),
  super(key: key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StoriesProvider of(BuildContext context) {
    return ((context.inheritFromWidgetOfExactType(StoriesProvider)) as StoriesProvider);
  }
  
}