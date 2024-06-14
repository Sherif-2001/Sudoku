import 'package:flutter/material.dart';

class ToolButton extends StatelessWidget {
  const ToolButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: const CircleBorder(),
          elevation: 0,
          shadowColor: Colors.transparent),
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.grey.shade600,
          ),
          Text(label, style: TextStyle(color: Colors.grey.shade600))
        ],
      ),
    );
  }
}
