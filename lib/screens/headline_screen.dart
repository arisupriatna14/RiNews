import 'package:flutter/material.dart';
import 'package:flutter_news/utils/font.dart';

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
    _tabController = TabController(vsync: this, length: 6);
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
            Text('Indonesia', style: HeadlineStyle.labelStyle),
            Text('World', style: HeadlineStyle.labelStyle),
            Text('Health', style: HeadlineStyle.labelStyle),
            Text('Sports', style: HeadlineStyle.labelStyle),
            Text('Entertainment', style: HeadlineStyle.labelStyle)
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            child: Center(child: Text('Latest', style: HeadlineStyle.labelStyle))
          ),
          Container(
            child: Center(child: Text('Indonesia', style: HeadlineStyle.labelStyle))
          ),
          Container(
            child: Center(child: Text('World', style: HeadlineStyle.labelStyle))
          ),
          Container(
            child: Center(child: Text('Health', style: HeadlineStyle.labelStyle))
          ),
          Container(
            child: Center(child: Text('Sports', style: HeadlineStyle.labelStyle))
          ),
          Container(
            child: Center(child: Text('Entertainment', style: HeadlineStyle.labelStyle))
          )
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