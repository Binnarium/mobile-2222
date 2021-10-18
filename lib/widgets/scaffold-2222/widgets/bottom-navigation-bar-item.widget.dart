import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class Lab2222BottomNavigationBarItem extends StatelessWidget {
  final ImageProvider icon;
  final VoidCallback? onTap;
  final Color iconColor;

  // ignore: sort_constructors_first
  Lab2222BottomNavigationBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    bool active = false,
  })  : iconColor = onTap == null

            /// when inactive color should be back
            ? Colors2222.black
            : kIsWeb

                /// by default on web, colors are white
                ? Colors2222.white
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
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ImageIcon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
