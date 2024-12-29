import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_notifier_provider.dart';

class InputForm extends ConsumerStatefulWidget {
  /// TextEditingControllerを破棄するためにStatefulWidgetを継承
  /// 逆を言えばControllerを利用しなければStatelessWidgetが好ましい
  const InputForm({super.key});

  @override
  ConsumerState<InputForm> createState() => _InputFormState();
}

class _InputFormState extends ConsumerState<InputForm> {
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _textEditingController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: '文章を入力してください',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '文章が入力されていません';
                  }
                  return null;
                },
              )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final formState = _formKey.currentState!;
              if (!formState.validate()) {
                return;
              }
              final sentence = _textEditingController.text;
              // ref.read プロバイダの値を取得する（監視はしない）
              await ref.read(appNotifierProvider.notifier).convert(sentence);

              debugPrint('変換結果:');
            },
            child: const Text('変換'),
          )
        ]));
  }
}
