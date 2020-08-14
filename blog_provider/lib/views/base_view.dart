import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

part 'base_view.g.dart';

@hwidget
Widget baseView<T extends ChangeNotifier>({
  T model,
  Widget child,
  Widget Function(BuildContext ctx, T model, Widget child) builder,
  void Function(T) onModelReady,
}) {
  useEffect(() {
    if (onModelReady != null) {
      onModelReady(model);
    }

    return () {};
  }, []);

  return ChangeNotifierProvider(
    create: (_) => model,
    child: Consumer<T>(builder: builder, child: child),
  );
}
