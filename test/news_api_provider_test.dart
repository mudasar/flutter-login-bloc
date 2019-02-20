import 'package:flutter_test/flutter_test.dart';
import 'package:login_bloc/src/models/item_model.dart';
import 'package:login_bloc/src/resources/news_api_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';


main()  {
  
  test('FetchTopIds returns a list of ids', () async {
    var newsApiProvider = NewsApiProvider();
    var ids = [1,2,3];

    var mockClient = MockClient((request) async {
      return Response(json.encode(ids), 200);
    });
    newsApiProvider.client = mockClient;
    var items = await newsApiProvider.fetchTopIds();
    print(items);

    expect(items, ids);
  });
  
  test('FetchItem returns a valid Item Model', () async {
    var newsApiProvider = NewsApiProvider();
    var jsonMap = {'id': 1, 'title':'some title', 'by': 'mudasar'};
    var itemModel = ItemModel.fromJson(jsonMap);

    var mockClient = MockClient((request) async {
      return Response(json.encode(jsonMap), 200);
    });
    newsApiProvider.client = mockClient;
    var item = await newsApiProvider.fetchItem(1);
    print(item);

    expect(item.id, itemModel.id);
  });


}