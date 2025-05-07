import 'package:flutter/material.dart';

class EmptyImagePreview extends StatelessWidget {
  final VoidCallback onTap;

  const EmptyImagePreview({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final previewWidth =
        constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth * 0.9;

        return Center(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: previewWidth,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color:Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  clipBehavior: Clip.hardEdge,
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
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
