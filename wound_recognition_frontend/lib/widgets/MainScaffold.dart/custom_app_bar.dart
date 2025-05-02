import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth < 600 ? 18 : 24;

    return AppBar(
      elevation: 4,
      backgroundColor: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
      foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      leading: IconButton(
        icon: Icon(Icons.menu, color: theme.appBarTheme.foregroundColor ?? Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: titleFontSize,
          fontWeight: FontWeight.bold,
          color: theme.appBarTheme.foregroundColor ?? Colors.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
