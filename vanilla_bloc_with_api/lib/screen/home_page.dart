import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vanilla_bloc_with_api/bloc/news_bloc.dart';
import 'package:vanilla_bloc_with_api/model/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newsBloc = NewsBloc();

  @override
  void initState() {
    newsBloc.newsEventSink.add(NewsActionEvents.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: Container(
        child: StreamBuilder<List<Article>>(
          stream: newsBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data![index];
                    String formattedTime = DateFormat("yyyy-MM-dd hh:mm:ss")
                        .format(article.publishedAt as DateTime);
                    return Container(
                      height: 80,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  article.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  formattedTime.toString(),
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  article.title.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  article.description.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
