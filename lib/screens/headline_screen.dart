import 'package:flutter/material.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/screens/webview_screen.dart';
import 'package:flutter_news/services/source_news_service.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:flutter_news/utils/font.dart';
import 'package:flutter_news/utils/helper.dart';
import 'package:flutter_news/widget/custom_route.dart';

class HeadlineScreen extends StatefulWidget {
  const HeadlineScreen({Key key}) : super(key: key);

  @override
  _HeadlineScreenState createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Headline", style: HeadlineStyle.headerLabelStyle),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8.0),
            child: IconButton(icon: Icon(Icons.search, size: 30.0), onPressed: () {}),
          )
        ],
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.account_circle, size: 30.0), onPressed: () {}),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Color(0XFF00a4df),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4,
          labelPadding: EdgeInsets.all(16.0),
          labelStyle: TextStyle(fontSize: 16.0),
          unselectedLabelStyle: TextStyle(fontSize: 16.0),
          tabs: <Widget>[
            Text('Latest', style: HeadlineStyle.labelStyle),
            Text('Technology', style: HeadlineStyle.labelStyle),
            Text('Science', style: HeadlineStyle.labelStyle),
            Text('Health', style: HeadlineStyle.labelStyle),
            Text('Sports', style: HeadlineStyle.labelStyle),
            Text('Entertainment', style: HeadlineStyle.labelStyle),
            Text('Business', style: HeadlineStyle.labelStyle)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ListHeadline(sourceId: 'cnn-es'),
          ListHeadline(sourceId: 'techradar'),
          ListHeadline(sourceId: 'new-scientist'),
          ListHeadline(sourceId: 'medical-news-today'),
          ListHeadline(sourceId: 'bbc-sport',),
          ListHeadline(sourceId: 'entertainment-weekly'),
          ListHeadline(sourceId: 'business-insider')
        ]
      )
    );
  }
}

class HeadlineStyle {
  static const TextStyle labelStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontSize.semiBold,
    fontFamily: Fonts.Raleway
  );

  static const TextStyle headerLabelStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontSize.semiBold,
    fontFamily: Fonts.Raleway
  );
}

class ListHeadline extends StatefulWidget {
  final String sourceId;
  ListHeadline({Key key, @required this.sourceId}) : super(key: key);

  @override
  _ListHeadlineState createState() => _ListHeadlineState();
}

class _ListHeadlineState extends State<ListHeadline> {
  Future<List<NewsModel>> getListHeadlineNews;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getListHeadlineNews = getDetailSourceNews(widget.sourceId);
  }

  Future<List<NewsModel>> _onRefresh() {
    setState(() {
      getListHeadlineNews = getDetailSourceNews(widget.sourceId);
    });

    return getListHeadlineNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: FutureBuilder(
          future: getListHeadlineNews,
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
          child: Card(
            margin: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        data[index].title,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontSize.semiBold,
                          fontFamily: Fonts.Raleway
                        )
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        Helper.formatDateTime(data[index].publishedAt),
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontSize.regular,
                          fontFamily: Fonts.Raleway
                        ),
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                ),
                ClipRRect(
                  child: Image.network(
                    data[index].urlToImage == 'null' ||
                    data[index].urlToImage == null ?
                    Constant.imagePlaceholder :
                    data[index].urlToImage,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 6,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ],
            ),
          ),
          onTap: () => Navigator.push(
            context,
            customRoutes(routes: WebViewScreen(url: data[index].url))
          ),
        );
      }
    );
  }
}