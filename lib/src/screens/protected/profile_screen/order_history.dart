import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/screens/protected/profile_screen/order_history_details.dart';
import 'package:mingly/src/screens/protected/profile_screen/profile_provider.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: RefreshIndicator(
        onRefresh: () => profileProvider.getOrderHistory(),
        child: ListView.builder(
          itemCount: profileProvider.orderHistoryModel.orders!.length,
          itemBuilder: (context, index) {
            final order = profileProvider.orderHistoryModel.orders![index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(order.eventName.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order #: ${order.orderNumber}'),
                      Text('Status: ${order.status}'),
                      Text(
                        'Created: ${order.createdAt?..toString().split(" ")[0]}',
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    profileProvider.selectedOrderHistory(
                      order.orderNumber.toString(),
                    );
                    context.push("/order-history-details");
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
