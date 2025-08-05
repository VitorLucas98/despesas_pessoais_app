import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
 
  const ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: 
          Text("${value.toStringAsFixed(2)}")),
        const SizedBox(height: 4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}