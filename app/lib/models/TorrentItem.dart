class TorrentItem {
  String? author;
  String? category;
  String? id;
  int? leeches;
  int? seeds;
  int? size;
  String? state;
  String? title;
  int? downloads;
  String? registered;
  String? host;

  TorrentItem(
      {this.author,
      this.category,
      this.id,
      this.leeches,
      this.seeds,
      this.size,
      this.state,
      this.title,
      this.downloads,
      this.registered,
      this.host});

  TorrentItem.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    category = json['category'];
    id = json['id'];
    leeches = json['leeches'];
    seeds = json['seeds'];
    size = json['size'];
    state = json['state'];
    title = json['title'];
    downloads = json['downloads'];
    registered = json['registered'];
    host = json['host'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['author'] = this.author;
    data['category'] = this.category;
    data['id'] = this.id;
    data['leeches'] = this.leeches;
    data['seeds'] = this.seeds;
    data['size'] = this.size;
    data['state'] = this.state;
    data['title'] = this.title;
    data['downloads'] = this.downloads;
    data['registered'] = this.registered;
    data['host'] = this.host;
    return data;
  }
}
