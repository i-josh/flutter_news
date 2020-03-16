import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'news_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/news_detail' : (context) => NewsDetail()
      },
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
    print(data.toString());
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
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/news_detail',
                    arguments: {
                      'urlToImage':articles[index]['urlToImage'],
                      'author': articles[index]['author'],
                      'publishedDate': articles[index]['publishedDate'],
                      'title': articles[index]['title']
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Image.network(
                            articles[index]['urlToImage'] ?? "no image found",
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Text(articles[index]['author'] ?? ""),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(articles[index]['publishedAt'] ?? ''),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4.0,8.0,4.0,8.0),
                            child: Text(
                              articles[index]['title' ?? ""],
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
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