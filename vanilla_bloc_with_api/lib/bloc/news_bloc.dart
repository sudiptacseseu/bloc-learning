import 'dart:async';

import 'package:vanilla_bloc_with_api/model/news.dart';
import 'package:vanilla_bloc_with_api/network/api_call.dart';

// Only these events can be happened
enum NewsActionEvents { Fetch, Delete }

class NewsBloc {
  // Single subscription stream controller that provides only one listener
  final _stateStreamController = StreamController<List<Article>>();

  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  // For state, exposing only a stream which outputs data and this can't be private
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<NewsActionEvents>();
  // For events, exposing only a sink which is an input and this can't be private
  Sink<NewsActionEvents> get newsEventSink => _eventStreamController.sink;

  NewsBloc() {
    // Continuously listening, whenever there is a new event, we want to map it to a new state
    _eventStreamController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(NewsActionEvents event) async {
    if (event == NewsActionEvents.Fetch) {
      try {
        var news = await ApiCall().getNews();
        // Mapping event to sink
        _newsSink.add(news.articles as List<Article>);
      } on Exception catch (e) {
        _newsSink.addError("Something went wrong!");
      }
    }
  }

  // Disposing the controllers to prevent memory lick
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
