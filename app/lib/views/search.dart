import 'package:app/models/TorrentItem.dart';
import 'package:flutter/material.dart';

import '../network/requests.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<TorrentItem>> futureTorrentItem;

  @override
  Widget build(BuildContext context) {
    futureTorrentItem = searchTorrents("flatout");
    return Scaffold(
        body: Scaffold(
          body: Center(
              child: FutureBuilder<List<TorrentItem>>(
                future: futureTorrentItem,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data![0].title!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
          ),
        ));
  }


}
