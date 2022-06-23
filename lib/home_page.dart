// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                await controller.goBack();
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.reload();
              },
              icon: Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: () {
                controller.clearCache();
                CookieManager().clearCookies();
              },
              icon: Icon(Icons.close),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                color: Colors.red,
                backgroundColor: Colors.black12,
              ),
              Expanded(
                child: WebView(
                  initialUrl: 'www.flutter.dev/',
                  javascriptMode: JavascriptMode.disabled,
                  onWebViewCreated: (controller) {
                    this.controller = controller;
                  },
                  onProgress: (progress) {
                    setState(
                      () {
                        this.progress = progress / 100;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
