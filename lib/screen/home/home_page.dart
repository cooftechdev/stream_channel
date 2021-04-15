import 'package:demo/screen/home/vne.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:xml2json/xml2json.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends LifeCycleApp<HomePage> {
  String linkRss = 'https://vnexpress.net/rss/phap-luat.rss';
  var dio = Dio();
  var xml2json = Xml2Json();
  List<Item> item = [];
  @override
  void initState() {
    _loadRss();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadRss() async {
    var response = await dio.get(linkRss);
    xml2json.parse(response.data);
    String jsonData = xml2json.toParker();
    item = vneFromJson(jsonData).rss.channel.item;
    setState(() {});
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo App'),
      ),
      body: SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => _launchURL(context, item[index].link),
                title: Text(item[index].title.replaceAll('\\', '')),
                subtitle: Text(removeAllHtmlTags(item[index].description)),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: item.length),
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  @override
  void onPause() {
    print('Test pause');
    super.onPause();
  }

  @override
  void onResume() {
    print('Test resume');
    super.onResume();
  }
}

abstract class LifeCycleApp<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @mustCallSuper
  void onPause() {
    print('AppLifecycleState state: Paused audio playback');
  }

  @mustCallSuper
  void onResume() {
    print('AppLifecycleState state: Resumed audio playback');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onPause();
    }
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }
}
