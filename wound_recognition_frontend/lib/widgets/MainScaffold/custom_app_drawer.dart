import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/constants/app_strings.dart';
import '../../constants/app_constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.appBarTheme.backgroundColor ?? theme.primaryColor,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: theme.appBarTheme.foregroundColor ?? Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              AppStrings.uploadPage,
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => context.go(AppConstants.UPLOADROUTE),
          ),
          ListTile(
            title: Text(
              AppStrings.resultPage,
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => context.go(AppConstants.RESULTROUTE),
          ),
        ],
      ),
    );
  }
}
