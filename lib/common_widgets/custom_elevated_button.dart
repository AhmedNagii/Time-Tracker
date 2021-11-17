import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key key,
      this.child,
      this.color,
      this.height = 50,
      this.borderRadius = 2.0,
      this.onPressed})
      : super(key: key);

  final Widget child;
  final Color color;
  final double height;
  final double borderRadius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius)),
            ),
            backgroundColor: MaterialStateProperty.all(color)),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
