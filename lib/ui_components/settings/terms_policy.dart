import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // String privacypolicylink =
  //     'https://drive.google.com/file/d/1G8bGL_hnHjFSTSP0KMOCRwww7LX4axPG/view';
  String privacypolicylink =
      'https://drive.google.com/file/d/1n1hygtujTYPbx8lxc0k3PqyfLRUJ3Cef/view?usp=sharing';
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Term and Policies'),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return errorMsg != ''
            ? Text(
                errorMsg,
                style: TextStyle(color: Colors.black),
              )
            : (privacypolicylink == ''
                ? Center(child: CircularProgressIndicator())
                : WebView(
                    initialUrl: privacypolicylink,
                    javascriptMode: JavascriptMode.unrestricted,
                  ));
      }),
    );
  }
}
