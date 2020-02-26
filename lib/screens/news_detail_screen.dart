import 'package:flutter/material.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/screens/webview_screen.dart';
import 'package:flutter_news/services/source_news_service.dart';
import 'package:flutter_news/widget/custom_card_news.dart';
import 'package:flutter_news/widget/custom_route.dart';

class NewsDetailScreen extends StatefulWidget {
  final String sourceId;
  final String name;
  const NewsDetailScreen({Key key, @required this.sourceId, @required this.name}) : super(key: key);

  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  Future<List<NewsModel>> getListDetailSourceNews;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getListDetailSourceNews = getDetailSourceNews(widget.sourceId);
  }

  Future<List<NewsModel>> _onRefresh() {
    setState(() {
      getListDetailSourceNews = getDetailSourceNews(widget.sourceId);
    });

    return getListDetailSourceNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        elevation: 0.8,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: FutureBuilder(
          future: getListDetailSourceNews,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 16.0),
                child: _listViewSourceNews(snapshot.data)
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Error ${snapshot.error}')
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  ListView _listViewSourceNews(List<NewsModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: CustomCardNews(data: data[index]),
          onTap: () => Navigator.push(
            context,
            customRoutes(routes: WebViewScreen(url: data[index].url))
          ),
        );
      }
    );
  }
}
