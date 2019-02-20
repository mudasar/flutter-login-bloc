import 'package:login_bloc/src/models/item_model.dart';
import 'package:login_bloc/src/resources/news_api_provider.dart';
import 'package:login_bloc/src/resources/news_db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbProvider,
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];


  Future<List<int>> fetchTopIds() async {
    // Todo iterate over when db provider do the magic
    return await sources[0].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item; 
    Source source;
    for (source in sources) {
      item =await source.fetchItem(id);
      if (item !=null) {
        break;
      }
    }

    for (var cache in caches) {
     cache.addItem(item); 
    }
    return item;
  }

}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}