import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'custom_app_drawer.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? bottomNavigationBar;

  const MainScaffold({super.key, required this.body, required this.title, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
