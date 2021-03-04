import 'package:flutter/material.dart';

class ButtonIcons extends StatelessWidget {
  const ButtonIcons(this.sideA, this.sideB);
  final IconData sideA;
  final IconData sideB;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        constraints: BoxConstraints.tight(Size(100.0, 30.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(sideA),
            SizedBox(
              width: 10.0,
            ),
            Text('או'),
            SizedBox(
              width: 10.0,
            ),
            Icon(sideB)
          ],
        ),
      ),
    );
  }
}
