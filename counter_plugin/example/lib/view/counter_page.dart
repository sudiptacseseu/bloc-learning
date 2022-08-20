import 'package:counter_plugin/cubit/counter_cubit.dart';
import 'package:counter_plugin/counter_plugin.dart';
import 'package:counter_plugin_example/view/counter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [CounterView].
/// {@endtemplate}
class CounterPage extends StatelessWidget {
  /// {@macro counter_page}
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterPlugin.buildPlugin(),
      child: CounterView(),
    );
  }
}
