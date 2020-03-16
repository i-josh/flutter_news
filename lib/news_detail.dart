import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  Map extras = {};

  @override
  Widget build(BuildContext context) {
    extras = extras.isNotEmpty ? extras : ModalRoute.of(context).settings.arguments;
    print(extras);
    return Scaffold(
      
    );
  }
}