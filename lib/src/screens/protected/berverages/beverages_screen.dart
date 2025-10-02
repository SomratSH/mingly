import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/components/helpers.dart';
import 'package:mingly/src/screens/protected/berverages/widget/beverage_item_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/screens/protected/berverages/widget/beverage_item_card.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:mingly/src/screens/protected/my_bottles/bottle_provider.dart';
import 'package:provider/provider.dart';

class BeveragesScreen extends StatelessWidget {
  const BeveragesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = context.watch<EventsProvider>();
    final bottleProvider = context.watch<BottleProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        title: const Text(
          'Menu (Optional)',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF2E2D2C),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Color(0xFF2E2D2C),
                    value: eventProvider.selectedCategory,
                    hint: const Text(
                      "Select Category",
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 14.23,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,
                    items: eventProvider.categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      eventProvider.updateCatagory(value);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2D2C),
                  borderRadius: BorderRadius.circular(7.12),
                ),
                child: TextField(
                  controller: TextEditingController(),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white, // make cursor visible
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Color(0xFF8E7A72),
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                    border: InputBorder.none,
                    isDense: true, // makes field tighter
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 14.23,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: List.generate(
                  bottleProvider.bottleList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BeverageItemCard(
                      imagePath: "lib/assets/images/bottle_one.jpg",
                      title: bottleProvider.bottleList[index].brand.toString(),
                      number:
                          "Qty - ${bottleProvider.bottleList[index].quantity.toString()}",
                      keepingDate: formatDate(
                        bottleProvider.bottleList[index].keepingDate.toString(),
                      ),
                      expiryDate: formatDate(
                        bottleProvider.bottleList[index].expiredDate.toString(),
                      ),
                      buttonText: "Add",
                      onTap: () {
                        eventProvider.addMenu(
                          bottleProvider.bottleList[index].id!,
                          1,
                        );
                        CustomSnackbar.show(
                          context,
                          message: "Added menu sucessfully",
                          backgroundColor: Colors.green,
                        );
                        print("Add button clicked!");
                      },
                    ),
                  ),
                ),
              ),

              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD1B26F),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {
                    context.push("/table-booking-confirmation");
                  },
                  child: Text('Next(${eventProvider.menuList.length} items)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
