import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_news/utils/constant.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({Key key, @required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _position = 1;

  _onPageStarted(String url) {
    setState(() {
      setState(() {
        _position = 1;
      });
    });
  } 

  _onPageFinished(String url) {
    setState(() {
      _position = 0;
    });
  }

  void choiceAction(String choice) {
    print(choice);
    switch (choice) {
      case ConstantMenu.share: {
        Share.share(widget.url);
        break;
      }
      case ConstantMenu.bookmark: {
        print('Bookmarked');
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            padding: EdgeInsets.all(16),
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return ConstantMenu.choices.map((String choices) {
                return PopupMenuItem(
                  value: choices,
                  child: Text(choices)
                );
              }).toList();
            }
          ),
        ],
      ),
      body: IndexedStack(
        index: _position,
        children: <Widget>[
          Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              onPageStarted: _onPageStarted,
              onPageFinished: _onPageFinished,
              gestureNavigationEnabled: true,
            );
          }),
          Container(
            child: Center(child: CircularProgressIndicator(),)
          )
        ],
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      }
    );
  }

}