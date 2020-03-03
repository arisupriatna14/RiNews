import 'package:flutter/material.dart';
import 'package:flutter_news/models/news_model.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:flutter_news/utils/font.dart';
import 'package:flutter_news/utils/helper.dart';

class CustomCardNews extends StatelessWidget {
  final NewsModel data;
  const CustomCardNews({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            child: Image.network(
              data.urlToImage == 'null' ||
              data.urlToImage == null ?
              Constant.imagePlaceholder :
              data.urlToImage,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.title, style: CustomCardStyle.title),
                SizedBox(height: 8.0),
                Text(data.description, style: CustomCardStyle.description),
                SizedBox(height: 8.0),
                Text(Helper.formatDateTime(data.publishedAt), style: CustomCardStyle.date)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCardStyle {
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontSize.semiBold,
    fontFamily: Fonts.Raleway
  );

  static const TextStyle description = TextStyle(
    fontSize: 16.0,
    fontWeight: FontSize.medium,
    fontFamily: Fonts.Raleway
  );

  static const TextStyle date = TextStyle(
    fontSize: 14.0,
    color: Colors.grey,
    fontWeight: FontSize.regular,
    fontFamily: Fonts.Raleway
  );
}