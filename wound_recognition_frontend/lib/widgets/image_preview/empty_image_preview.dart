import 'package:flutter/material.dart';

class EmptyImagePreview extends StatelessWidget {
  final VoidCallback onTap;

  const EmptyImagePreview({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final previewWidth =
        constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth * 0.9;

        return Center(
          child: GestureDetector(
            onTap: onTap, // Callback wordt aangeroepen wanneer er op de container wordt getikt
            child: Container(
              width: previewWidth,
              height: previewWidth * 3 / 4, // Zorgt ervoor dat de aspect ratio klopt
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              clipBehavior: Clip.hardEdge,
              child: Center(  // Center de inhoud binnen de container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.black,
                      size: 48,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Klik om camera te openen",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
