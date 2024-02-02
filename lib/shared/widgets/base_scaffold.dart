import 'package:flutter/material.dart';

//

class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Color? bgColor;
  final Widget? leading;

  const BaseScaffold({
    required this.body,
    this.bgColor,
    this.title = 'Chatte',
    this.leading,
    super.key,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: leading,
          ),
          backgroundColor: bgColor,
          body: body,
        ),
      );
}
