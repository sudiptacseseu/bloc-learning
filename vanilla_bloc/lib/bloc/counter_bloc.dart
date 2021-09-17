import 'dart:async';

import 'counter_event.dart';

// Only these events can be happened
// enum CounterEvents { Increment, Decrement, Reset }

class CounterBloc {
  int _counter = 0;

  // Single subscription stream controller that provides only one listener
  final _stateStreamController = StreamController<int>();

  // Broadcast stream controller that provide multiple listeners
  // final _stateStreamController = StreamController<int>.broadcast();

  StreamSink<int> get _counterSink => _stateStreamController.sink;
  // For state, exposing only a stream which outputs data and this can't be private
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterEvent>();
  // For events, exposing only a sink which is an input and this can't be private
  Sink<CounterEvent> get counterEventSink => _eventStreamController.sink;

  CounterBloc() {
    // Multiple listener for state stream controller, one is from stream builder and another one is this one
    // _stateStreamController.stream.listen((event) {});
    // Continuously listening, whenever there is a new event, we want to map it to a new state
    _eventStreamController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;

    // Mapping event to sink
    _counterSink.add(_counter);
  }

  // Disposing the controllers to prevent memory lick
  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
