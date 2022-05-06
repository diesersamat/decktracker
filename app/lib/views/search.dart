import 'dart:async';

import 'package:app/models/TorrentItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../network/requests.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final StreamController<List<TorrentItem>> _torrentItemsStream =
      StreamController<List<TorrentItem>>();
  final _scrollController = ScrollController();
  final searchController = TextEditingController();
  late Future<List<TorrentItem>> futureTorrentItem = searchTorrents("");
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _torrentItemsStream.add(List.empty());
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      _debounce = Timer(const Duration(seconds: 1), () {
        if (searchController.text.length > 3) {
          _loadTorrentItems();
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _torrentItemsStream.close();
    super.dispose();
  }

  void _loadTorrentItems() async => {
        await searchTorrents(searchController.text)
            .then((torrents) => {_torrentItemsStream.add(torrents)})
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0)),
                        hintText: 'Type a game name to start search...'),
                    controller: searchController,
                  ))),
          Expanded(
            flex: 10,
            child: StreamBuilder<List<TorrentItem>>(
              stream: _torrentItemsStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.isNotEmpty == true) {
                  return Scrollbar(
                    controller: _scrollController,
                      scrollbarOrientation: ScrollbarOrientation.right,
                      isAlwaysShown: true,
                      child: GridView.count(
                        controller: _scrollController,
                        physics: const ScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.all(20),
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount:
                            MediaQuery.of(context).size.shortestSide < 600
                                ? 2
                                : 4,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(snapshot.data!.length, (index) {
                          return Center(
                            child: Text(
                              '${snapshot.data![index].title}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          );
                        }),
                      ));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    ));
  }
}
