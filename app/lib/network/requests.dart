import 'dart:convert';

import 'package:app/models/TorrentItem.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<List<TorrentItem>> searchTorrents(String query) async {
  if (query.isEmpty) {
    return List.empty();
  }

  final queryParameters = {'q': query};

  final response = await MyClient(http.Client())
      .get(Uri.http('desktracker.herokuapp.com', 'search', queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable l = json.decode(response.body);
    return List<TorrentItem>.from(
        l.map((model) => TorrentItem.fromJson(model)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class MyClient extends BaseClient {
  MyClient(this.delegate);

  final Client delegate;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    debugPrint(request.toString());
    return delegate.send(request);
  }

  @override
  void close() => delegate.close();
}
