import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({super.key, required this.title, required this.onTap});

  final String title;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          trailing: _buildTrailing(),
        ),
      ),
    );
  }

  Container _buildTrailing() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.green[50],
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check_circle, color: Colors.green, size: 28),
    );
  }
}
