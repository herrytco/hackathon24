import 'package:flutter/material.dart';
import 'package:hackathon24/constants/theme_data.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, kelagGreen],
              )
            : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: kelagGreen,
        ),
        title: Text(label),
      ),
    );
  }
}
