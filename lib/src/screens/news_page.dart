import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/stories_bloc.dart';
import 'dart:async';

import 'package:login_bloc/src/blocs/stories_provider.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final bloc =StoriesProvider.of(context).bloc;
    bloc.fetchTopIds();


    return StoriesProvider(child: Scaffold(
      appBar: AppBar(
        title: Text('News List'),
      ),
      body:  buildList(bloc),
    ));
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('Still waiting on Ids');
            }
            ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, int index) {
          return Text(snapshot.data[index].toString());
        },
      );
          }
           
    );
  }

  getFuture() {
    return Future.delayed(Duration(seconds: 2), () => 'hi');
  }
}
