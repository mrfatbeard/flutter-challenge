import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

mixin MobXAutoDisposeMixin<W extends StatefulWidget> on State<W> {
  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    _disposers.forEach((e) => e());
    super.dispose();
  }
}

extension DisposerExt on ReactionDisposer {
  void autoDispose(MobXAutoDisposeMixin disposableMixin) {
    disposableMixin._disposers.add(this);
  }
}
