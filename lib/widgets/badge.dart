import 'package:flutter/material.dart';

class BadgeForCart extends StatelessWidget {
  const BadgeForCart({
    super.key,
    required this.value,
    required this.child,
  });

  // shortcut key to reformat code is Ctrl Alt L

  final Widget child;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.centerRight,
      children: [
        child,
        Positioned(
          left: 30,
          top: 10,
          child: Container(
            alignment: Alignment.center,
            color: Colors.deepOrange,
            width: 12,
            height: 12,
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ],
    );
  }
}
