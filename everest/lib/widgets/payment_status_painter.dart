import 'package:flutter/material.dart';

class PaymentStatusPainter extends CustomPainter {
  final double totalAmount;
  final double paidAmount;
  final double unpaidAmount;

  PaymentStatusPainter({
    required this.totalAmount,
    required this.paidAmount,
    required this.unpaidAmount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final totalWidth = size.width;
    final totalHeight = size.height;

    final totalPaint = Paint()..color = Colors.yellow;
    final paidPaint = Paint()..color = Colors.red;
    final unpaidPaint = Paint()..color = Colors.green;

    final totalBarWidth = totalWidth;
    final paidBarWidth = (paidAmount / totalAmount) * totalWidth;
    final unpaidBarWidth = (unpaidAmount / totalAmount) * totalWidth;

    canvas.drawRect(Rect.fromLTWH(0, 0, totalBarWidth, totalHeight), totalPaint);

    canvas.drawRect(Rect.fromLTWH(0, 0, paidBarWidth, totalHeight), paidPaint);

    canvas.drawRect(Rect.fromLTWH(paidBarWidth, 0, unpaidBarWidth, totalHeight), unpaidPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
