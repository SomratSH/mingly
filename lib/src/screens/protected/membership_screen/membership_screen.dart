import 'package:flutter/material.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/screens/protected/booking_summary/widget/custom_confirm_dialog.dart';
import 'package:mingly/src/screens/protected/home_screen/home_proivder.dart';
import 'package:mingly/src/screens/protected/payment/payment_stripe_table.dart';
import 'package:provider/provider.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeProvider = context.watch<HomeProivder>();
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Membership Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Membership status card - Fixed structure
            SizedBox(
              height: 200,
              child: PageView(
                children: List.generate(homeProvider.packageList.length, (
                  index,
                ) {
                  return InkWell(
                    onTap: () async {
                      LoadingDialog.show(context);
                      final status = await homeProvider.upgradePlanData({
                        "level": homeProvider.packageList[index].name,
                      });
                      LoadingDialog.hide(context);

                      if (status["checkout_url"] != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StripePaymentWebViewTable(
                              url: status["checkout_url"],
                            ),
                          ),
                        );
                      } else {
                        CustomSnackbar.show(
                          context,
                          message: "Getting some error",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    child: Card(
                      color: homeProvider.packageList[index].name == "basic"
                          ? Colors.blueGrey
                          : homeProvider.packageList[index].name == "silver"
                          ? Colors.grey.shade300
                          : homeProvider.packageList[index].name == "gold"
                          ? const Color(0xffD4AF37)
                          : homeProvider.packageList[index].name == "platinum"
                          ? Color(0xffD9D9D9)
                          : Color(0xffBC5090),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Membership Status',
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              homeProvider.packageList[index].description!
                                  .toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              homeProvider.packageList[index].benefits
                                  .toString(),
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

                // [
                //   Card(
                //     color: const Color(0xffD4AF37),
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           Text('Membership Status', style: TextStyle(color: Colors.black54)),
                //           SizedBox(height: 8),
                //           Text('Gold', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                //           SizedBox(height: 8),
                //           Text('Access to more events, priority booking, member-only ticket discounts', style: TextStyle(color: Colors.black54)),
                //         ],
                //       ),
                //     ),
                //   ),
                //   Card(
                //     color: Colors.grey.shade300,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           Text('Membership Status', style: TextStyle(color: Colors.black54)),
                //           SizedBox(height: 8),
                //           Text('Silver', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                //           SizedBox(height: 8),
                //           Text('Access to more events, priority booking, member-only ticket discounts', style: TextStyle(color: Colors.black54)),
                //         ],
                //       ),
                //     ),
                //   ),
                //   // Add a third card for demonstration
                //   Card(
                //     color: const Color(0xffCD7F32), // Bronze color
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                //     child: Padding(
                //       padding: const EdgeInsets.all(12),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           Text('Membership Status', style: TextStyle(color: Colors.black54)),
                //           SizedBox(height: 8),
                //           Text('Bronze', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                //           SizedBox(height: 8),
                //           Text('Basic access to events and standard booking', style: TextStyle(color: Colors.black54)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ),

            const SizedBox(height: 8),
            // Indicator dots
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Member benefits section
            const Text(
              'Member Benefits',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Discount 5%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Amet consequat tempor congue elit nisi nunc eu gravida.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.grey.shade900,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Priority Booking',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Only Silver Members Get to book special bookings',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
