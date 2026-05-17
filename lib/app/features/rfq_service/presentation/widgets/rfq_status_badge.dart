import 'package:flutter/material.dart';

class RfqStatusBadge extends StatelessWidget {
  final String status;

  const RfqStatusBadge({super.key, required this.status});

  Color _getStatusColor() {
    switch (status) {
      case 'accepted':
        return Colors.green;

      case 'rejected':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 'accepted':
        return 'مقبول';

      case 'rejected':
        return 'مرفوض';

      default:
        return 'قيد الانتظار';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withValues(alpha: .18),
            statusColor.withValues(alpha: .08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: statusColor.withValues(alpha: .25)),

        boxShadow: [
          BoxShadow(
            color: statusColor.withValues(alpha: .10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Status Dot
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 8),

          /// Status Text
          Text(
            _getStatusText(),
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
