import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final String flag;
  final String code;
  final VoidCallback onTap;

  const CurrencySelector({
    super.key,
    required this.flag,
    required this.code,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Flag placeholder
            CircleAvatar(
              radius: 22.5,
              backgroundColor: Colors.transparent,
              child: Text(flag, style: const TextStyle(fontSize: 25)),
            ),
            const SizedBox(width: 8),
            Text(
              code,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF26278D),
              ),
            ),
            const Spacer(),
            Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
