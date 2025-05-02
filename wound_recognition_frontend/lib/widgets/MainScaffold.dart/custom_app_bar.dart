import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // get width
    double screenWidth = MediaQuery.of(context).size.width;

    // change textsize based on width
    double titleFontSize = screenWidth < 600 ? 18 : 24; // Kleinere tekst voor smallere schermen

    return AppBar(
      elevation: 4, // shadow
      backgroundColor: Colors.blueAccent, //Color
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white), // menu icon left side
        onPressed: () {
          // open drawer on press
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: titleFontSize, // dynamic size
          fontWeight: FontWeight.bold,
          color: Colors.white, // textcolor
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
