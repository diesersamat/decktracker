import 'dart:convert';

import 'package:app/models/TorrentItem.dart';
import 'package:http/http.dart' as http;

Future<List<TorrentItem>> searchTorrents(String query) async {
  final queryParameters = {'q': query};

  final response =
      await http.get(Uri.http('localhost:3000', 'search', queryParameters));

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
