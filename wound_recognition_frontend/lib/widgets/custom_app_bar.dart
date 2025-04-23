import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget
{
  const CustomAppBar(
      {
        super.key, required this.title
      }
      )
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  final String title;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context)
  {
    return AppBar(
      title: Text(title),
    );
  }
}