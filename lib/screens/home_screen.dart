import 'package:flutter/material.dart';
import 'package:flutter_news/models/source_news_model.dart';
import 'package:flutter_news/services/source_news_service.dart';
import 'package:flutter_news/widget/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<SourceNewsModel>> getDataSourceNews;

  @override
  void initState() {
    super.initState();
    getDataSourceNews = getSourceNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('News'),
      body: FutureBuilder(
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
    );
  }

  ListView _listViewSourceNews(List<SourceNewsModel> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[index].name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  )
                ),
                SizedBox(height: 8),
                Text(data[index].description)
              ],
            ),
          ),
        );
      }
    );
  }
}