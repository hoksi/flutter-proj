import 'package:flutter/material.dart';
import '../const/colors.dart';

class TileWidget extends StatelessWidget {
  final int value;

  const TileWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: tileColors[value] ?? Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: value <= 4 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
