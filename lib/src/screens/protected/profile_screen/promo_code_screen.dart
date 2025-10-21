import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mingly/src/screens/protected/profile_screen/profile_provider.dart';
import 'package:provider/provider.dart';

class PromoListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> promoList = [
    {
      "id": 4,
      "code": "WELCOME5",
      "discount_type": "fixed",
      "discount_value": "5.00",
      "start_date": "2025-02-01T00:00:00Z",
      "end_date": "2025-12-31T00:00:00Z",
      "status": "active",
    },
    {
      "id": 5,
      "code": "SUMMER20",
      "discount_type": "percent",
      "discount_value": "20",
      "start_date": "2025-06-01T00:00:00Z",
      "end_date": "2025-08-31T00:00:00Z",
      "status": "expired",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Promo Codes"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: provider.promoCodeList.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final promo = provider.promoCodeList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PromoCodeCard(
              code: promo.code.toString(),
              discountType: promo.discountType!,
              discountValue: promo.discountValue!,
              startDate: promo.startDate!,
              endDate: promo.endDate!,
              status: promo.status!,
            ),
          );
        },
      ),
    );
  }
}

class PromoCodeCard extends StatelessWidget {
  final String code;
  final String discountType;
  final String discountValue;
  final String startDate;
  final String endDate;
  final String status;

  const PromoCodeCard({
    super.key,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final formattedStart = DateFormat(
      'MMM dd, yyyy',
    ).format(DateTime.parse(startDate));
    final formattedEnd = DateFormat(
      'MMM dd, yyyy',
    ).format(DateTime.parse(endDate));

    return Card(
      color: Colors.grey.shade900,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Top row with Code and Active Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  code,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: status == 'active' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- Discount type and value
            Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.white70, size: 18),
                const SizedBox(width: 6),
                Text(
                  discountType == 'fixed'
                      ? "Discount: \$${discountValue}"
                      : "Discount: $discountValue%",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- Validity dates
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.white54,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  "Valid: $formattedStart → $formattedEnd",
                  style: const TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
