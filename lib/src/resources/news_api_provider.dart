import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'dart:async';

import 'package:login_bloc/src/models/item_model.dart';
import 'package:login_bloc/src/resources/repository.dart';


final _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {

  Client client =Client();

  Future<List<int>> fetchTopIds() async{
    final result = await client.get('$_root/topstories.json');
    final ids = json.decode(result.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final result = await client.get('$_root/item/$id.json');
    final parsedJson = json.decode(result.body);
    return ItemModel.fromJson(parsedJson);
  }
  
}