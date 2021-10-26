import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardSection extends StatelessWidget {
  final List<Widget> children;
  final String headerText;

  final Widget? headerTrailing;

  final String? headerSubtitleText;
  const CardSection({
    Key? key,
    required this.children,
    required this.headerText,
    this.headerTrailing,
    this.headerSubtitleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              headerText,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: headerSubtitleText != null
                ? Text(
                    headerSubtitleText!,
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .headline6!
                    //     .copyWith(fontWeight: FontWeight.bold),
                  )
                : null,
            trailing: headerTrailing,
          ),
          ...children,
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
