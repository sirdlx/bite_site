import 'package:flutter/material.dart';

class LBRouteWidget extends StatelessWidget {
  final Widget child;
  final String path;
  // final AdaptiveScaffoldDestination? destination;

  final IconData? icon;
  final String? title;
  final Color? backgroundColor;

  final PageRoute Function()? onRequired;
  final Widget Function(BuildContext context, String? path)? builder;

  final bool? routeInTab;

  final bool? routeInDrawer;

  bool get requiresLogin =>
      onRequiresLogin != null ? onRequiresLogin!() : false;

  Function? onRequiresLogin;

  LBRouteWidget({
    Key? key,
    required this.path,
    required this.child,
    // this.destination,
    this.icon,
    this.title,
    this.backgroundColor,
    this.onRequired,
    this.builder,
    this.routeInTab,
    this.routeInDrawer,
    this.onRequiresLogin,
    // PageRoute onRequired({RouteSettings settings, FlavorAdminState appState}),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder!(context, this.path);
    }

    return child != null
        ? Scaffold(body: child)
        : Scaffold(
            body: Container(
              child: Center(
                child: Text('No state exist for route "$path" '),
              ),
            ),
          );
  }
}
