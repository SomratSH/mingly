import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_loading_dialog.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/screens/protected/berverages/widget/menu_card.dart';
import 'package:mingly/src/screens/protected/berverages/widget/table_card.dart';
import 'package:mingly/src/screens/protected/booking_summary/widget/custom_confirm_dialog.dart'
    show showCustomConfirmDialogEventTicket;
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/my_bottles/bottle_provider.dart';
import 'package:mingly/src/screens/protected/payment/payment_stripe_table.dart';
import 'package:mingly/src/screens/protected/venue_list_screen/venue_provider.dart';
import 'package:provider/provider.dart';

class TableBookingConfirmationScreen extends StatelessWidget {
  const TableBookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final eventProvider = context.watch<EventsProvider>();
    final venueProvider = context.watch<VenueProvider>();
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
          'Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                // eventProvider.selectEventModel.eventName.toString(),
                "fdsaf",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Fri, 26 Jan 2025',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  'Open gate at 20:00',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  Icon(Icons.store, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Outlet', style: TextStyle(color: Colors.white)),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 32),
                child: Text(
                  '${eventProvider.selectEventModel.venueName}\nCity - ${eventProvider.selectEventModel.venueCity}',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SvgPicture.asset("lib/assets/icons/Menu.svg"),
                  SizedBox(width: 10),
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: const Color(0xFFFFFAE5),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(
                  eventProvider.menuList.length,
                  (index) => MenuCard(
                    menuName: venueProvider.getMenuName(
                      eventProvider.menuList[index].id!,
                    ),
                    price:
                        "\$${venueProvider.getMenuPrice(eventProvider.menuList[index].id!)}",
                    quantity: eventProvider.menuList[index].quantity.toString(),
                    subtotal:
                        "\$${venueProvider.getMenuPrice(eventProvider.menuList[index].id!)}",
                    onDelete: () {
                      eventProvider.removeMenu(index);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset("lib/assets/icons/Table.svg"),
                  SizedBox(width: 10),
                  Text(
                    'Table',
                    style: TextStyle(
                      color: const Color(0xFFFFFAE5),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TableCard(
                no:
                    eventProvider.getChair(
                      eventProvider.tableBooking.seatId!,
                    ) ??
                    [],
                downPayment:
                    "${eventProvider.selecteTable.price! * double.parse(eventProvider.selecteTable.chairs!.length.toString())}",
                minimumCharge:
                    "${eventProvider.selecteTable.price! * double.parse((eventProvider.selecteTable.chairs!.length - 3).toString())}",
                tableCount: "1",
                totalDownPayment:
                    "${eventProvider.selecteTable.price! * double.parse((eventProvider.selecteTable.chairs!.length - 3).toString())}",
                onDelete: () {
                  print("Deleted");
                },
              ),

              const SizedBox(height: 16),
              const Text(
                'Promo Code',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        eventProvider.getPromoCode(value);
                        eventProvider.calculateTotalAmountWithPromo(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade900,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset("lib/assets/icons/Promo.svg"),
                        ),
                        hintText: 'Enter promo code',
                        hintStyle: const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 8,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () {
                      eventProvider.addPromoValue();
                    },
                    child: const Text('Apply'),
                  ),
                ],
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${eventProvider.selecteTable.price! * double.parse((eventProvider.selecteTable.chairs!.length - 3).toString())}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Promo', style: TextStyle(color: Colors.white)),
                          Text(
                            eventProvider.promoValue.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Grand Total',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${eventProvider.selecteTable.price! * double.parse((eventProvider.selecteTable.chairs!.length - 3).toString())}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  // FIRST CHILD
                  Row(
                    children: [
                      const Text('Down payment'),
                      const SizedBox(width: 8),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch.adaptive(
                          value: eventProvider.isDownPayment,
                          onChanged: (v) => eventProvider.toggleDownPayment(v),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Text(
                    eventProvider.isDownPayment ? 'Will apply' : 'Not applied',
                    style: TextStyle(
                      color: eventProvider.isDownPayment
                          ? Colors.green
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1B26F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    LoadingDialog.show(context);
                  
                    final status = await eventProvider.buyTableTicketEvent(
                      eventProvider.tableBooking.toJson(),
                      eventProvider.selectEventModel.id.toString(),
                    );
                    LoadingDialog.hide(context);

                    if (status["success"] == true &&
                        status["checkout_url"] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StripePaymentWebViewTable(
                            url: status["checkout_url"],
                          ),
                        ),
                      ).then((e) {
                        showCustomConfirmDialogEventTicket(
                          context,
                          eventProvider.selectedTickets.length.toString(),
                          "table booking successfully",
                        );
                      });
                    } else {
                      CustomSnackbar.show(
                        context,
                        message: "Getting some error",
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  child: const Text('Proceed'),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
