import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hiragana_converter/app_notifier_provider.dart';
import 'package:hiragana_converter/app_state.dart';
import 'package:hiragana_converter/loading_indicator.dart';

import 'convert_result.dart';
import 'input_form.dart';

void main() {
  // riverpodを利用するためにProviderScope Widgetで包む
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiragana Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hiragana Converter'),
      ),
      body: switch (appState) {
        Loading() => const LoadingIndicator(),
        Input() => const InputForm(),
        // マッチしたData型のオブジェクトからsentenceパラメータを参照し、それをローカル変数として参照できるようにしている
        Data(sentence: final sentence) => ConvertResult(sentence: sentence),
      },
    );
  }
}
