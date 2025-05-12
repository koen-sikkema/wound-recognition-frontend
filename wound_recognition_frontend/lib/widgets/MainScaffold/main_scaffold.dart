import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'custom_app_drawer.dart';

class MainScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;

  const MainScaffold({super.key, required this.body, required this.title, this.bottomNavigationBar, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: title),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh ?? () async{}, // Default empty function for non implemented pages
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            body,
          ],
        )
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
  Future<void> _handleRefresh() async
  {
    Future.delayed(const Duration(seconds: 1));
    if(onRefresh != null){
      await onRefresh!();
    }
  }
}
