import 'package:flutter/material.dart';

class MetricRow extends StatelessWidget {
  const MetricRow({
    required this.label,
    required this.value,
    super.key,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
