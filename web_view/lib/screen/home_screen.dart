import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? webViewController;
  final homeUrl = 'https://blog.codefactory.ai';

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Code Factory'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (webViewController == null) {
                  return;
                }
                webViewController?.loadUrl(homeUrl);
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          this.webViewController = webViewController;
        },
        initialUrl: homeUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
