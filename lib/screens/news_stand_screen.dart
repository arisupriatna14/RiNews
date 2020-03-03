import 'package:flutter/material.dart';
import 'package:flutter_news/models/source_news_model.dart';
import 'package:flutter_news/screens/news_detail_screen.dart';
import 'package:flutter_news/services/source_news_service.dart';
import 'package:flutter_news/utils/font.dart';
import 'package:flutter_news/widget/custom_appbar.dart';
import 'package:flutter_news/widget/custom_route.dart';

class NewsStandScreen extends StatefulWidget {
  const NewsStandScreen({Key key}) : super(key: key);

  @override
  _NewsStandScreenState createState() => _NewsStandScreenState();
}

class _NewsStandScreenState extends State<NewsStandScreen> {
  Future<List<SourceNewsModel>> getDataSourceNews;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getDataSourceNews = getSourceNews();
  }

  Future<List<SourceNewsModel>> _refresh() {
    setState(() {
      getDataSourceNews = getSourceNews();
    });

    return getDataSourceNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Newsstand'),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: getDataSourceNews,
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

  GridView _listViewSourceNews(List<SourceNewsModel> data) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0
          ),
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.assessment, size: 50, color: Colors.blueGrey),
                  SizedBox(height: 8),
                  Text(data[index].name, style: NewsStandStyle.styleName, textAlign: TextAlign.center),
                  SizedBox(height: 8),
                ],
              ),
            ),
            onTap: () => Navigator.push(
              context,
              customRoutes(routes: NewsDetailScreen(sourceId: data[index].id, name: data[index].name)),
            ),
          ),
        );
      },
    );
  }
}

class NewsStandStyle {
  static const TextStyle styleName = TextStyle(
    fontSize: 16,
    fontWeight: FontSize.semiBold,
    fontFamily: Fonts.Raleway
  );
}