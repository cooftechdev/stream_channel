import 'dart:convert';

Vne vneFromJson(String str) => Vne.fromJson(json.decode(str));

String vneToJson(Vne data) => json.encode(data.toJson());

class Vne {
  Vne({
    this.rss,
  });

  Rss rss;

  factory Vne.fromJson(Map<String, dynamic> json) => Vne(
        rss: Rss.fromJson(json["rss"]),
      );

  Map<String, dynamic> toJson() => {
        "rss": rss.toJson(),
      };
}

class Rss {
  Rss({
    this.channel,
  });

  Channel channel;

  factory Rss.fromJson(Map<String, dynamic> json) => Rss(
        channel: Channel.fromJson(json["channel"]),
      );

  Map<String, dynamic> toJson() => {
        "channel": channel.toJson(),
      };
}

class Channel {
  Channel({
    this.title,
    this.description,
    this.image,
    this.pubDate,
    this.generator,
    this.link,
    this.item,
  });

  String title;
  String description;
  Image image;
  String pubDate;
  String generator;
  String link;
  List<Item> item;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
        title: json["title"],
        description: json["description"],
        image: Image.fromJson(json["image"]),
        pubDate: json["pubDate"],
        generator: json["generator"],
        link: json["link"],
        item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image.toJson(),
        "pubDate": pubDate,
        "generator": generator,
        "link": link,
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.url,
    this.title,
    this.link,
  });

  String url;
  String title;
  String link;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "link": link,
      };
}

class Item {
  Item({
    this.title,
    this.description,
    this.pubDate,
    this.link,
    this.guid,
    this.slashComments,
  });

  String title;
  String description;
  String pubDate;
  String link;
  String guid;
  String slashComments;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        description: json["description"],
        pubDate: json["pubDate"],
        link: json["link"],
        guid: json["guid"],
        slashComments: json["slash:comments"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "pubDate": pubDate,
        "link": link,
        "guid": guid,
        "slash:comments": slashComments,
      };
}
