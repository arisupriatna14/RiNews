import 'package:flutter/material.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/screens/webview_screen.dart';
import 'package:flutter_news/services/news_service.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:flutter_news/widget/custom_appbar.dart';
import 'package:flutter_news/widget/custom_card_news.dart';
import 'package:flutter_news/widget/custom_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<NewsModel>> getListTopHeadlineNews;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getListTopHeadlineNews = getTopHeadlineNews(Constant.countryId);
  }

  Future<List<NewsModel>> _refresh() {
    setState(() {
      getListTopHeadlineNews = getTopHeadlineNews(Constant.countryId);
    });

    return getListTopHeadlineNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'RiNews'),
      body: RefreshIndicator(
        onRefresh: _refresh,
        key: _refreshIndicatorKey,
        child: FutureBuilder(
          future: getListTopHeadlineNews,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(top: 16.0),
                child: _listViewSourceNews(snapshot.data)
              );
            } else if (snapshot.hasError) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text('Error ${snapshot.error}')
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        _refreshIndicatorKey.currentState.show();
                      },
                    )
                  ],
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
            customRoutes(
              routes: WebViewScreen(url: data[index].url)
            ),
          ),
        );
      }
    );
  }
}
