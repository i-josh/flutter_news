import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data;
  List articles;

  Future getData() async{
    http.Response response = await http.get('http://newsapi.org/v2/top-headlines?country=us&apiKey=7632ef2bf27146068b40dec63660adf6');
    data = json.decode(response.body);
    setState(() {
      articles = data['articles'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            title: Text('Flutter News'),
            floating: true,
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index){
                if(articles[index]['urlToImage'] != null)
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          articles[index]['urlToImage']),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(articles[index]['publishedAt']),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0,8.0,4.0,8.0),
                          child: Text(
                            articles[index]['title'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: articles == null ? 0 : articles.length
            ),
          )
        ],
        ),
    );
  }
}