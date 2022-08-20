import 'package:bloc/bloc.dart';
import 'package:counter_plugin_example/app.dart';
import 'package:counter_plugin_example/counter_observer.dart';
import 'package:flutter/widgets.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(const CounterApp());
}
