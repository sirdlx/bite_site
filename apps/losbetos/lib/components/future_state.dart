import 'package:flutter/cupertino.dart';

class FutureState<T> extends StatelessWidget {
  final Widget? noneWidget;

  final Widget? waitingWidget;

  final Widget? activeWidget;

  final Widget? doneWidget;
  final Function(BuildContext, T) doneWidgetBuilder;

  final Future<T>? future;

  const FutureState({
    Key? key,
    this.noneWidget,
    this.waitingWidget,
    this.activeWidget,
    this.doneWidget,
    this.future,
    required this.doneWidgetBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return noneWidget ?? Container();
          case ConnectionState.waiting:
            return waitingWidget ?? Container();
          case ConnectionState.active:
            return activeWidget ?? Container();
          case ConnectionState.done:
            return snapshot.data != null && !snapshot.hasData
                ? doneWidgetBuilder(context, snapshot.data!)
                : noneWidget != null
                    ? noneWidget
                    : Container();
        }
      },
    );
  }
}
