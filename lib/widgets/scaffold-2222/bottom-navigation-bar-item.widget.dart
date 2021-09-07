import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class Lab2222BottomNavigationBarItem extends StatelessWidget {
  final ImageProvider icon;
  final VoidCallback? onTap;
  final Color iconColor;

  Lab2222BottomNavigationBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    bool active = false,
  })  : this.iconColor = onTap == null
            ? Colors2222.black
            : active
                ? Colors2222.white
                : Colors2222.white.withOpacity(0.5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Material(
        color: Colors2222.black,
        child: InkWell(
          onTap: this.onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12),
            child: ImageIcon(
              this.icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
