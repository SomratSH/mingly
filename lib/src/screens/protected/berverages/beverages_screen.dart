import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mingly/src/screens/protected/berverages/widget/beverage_item_card.dart';

class BeveragesScreen extends StatefulWidget {
  const BeveragesScreen({super.key});

  @override
  State<BeveragesScreen> createState() => _BeveragesScreenState();
}

class _BeveragesScreenState extends State<BeveragesScreen> {
  String? selectedCategory;
  final List<String> categories = [
    'Coffee',
    'Tea',
    'Juice',
    'Soft Drinks',
    'Smoothies',
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF2E2D2C),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: const Color(0xFF2E2D2C),
                    value: selectedCategory,
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
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2D2C),
                  borderRadius: BorderRadius.circular(7.12),
                ),
                child: TextField(
                  controller: searchController,
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
              BeverageItemCard(
                imagePath: "lib/assets/images/bottle_one.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
                buttonText: "Add",
                onTap: () {
                  print("Add button clicked!");
                },
              ),
              SizedBox(height: 10),
              BeverageItemCard(
                imagePath: "lib/assets/images/bottle_two.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
                buttonText: "Add",
                onTap: () {
                  print("Add button clicked!");
                },
              ),
              SizedBox(height: 10),
              BeverageItemCard(
                imagePath: "lib/assets/images/bottle_three.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
                buttonText: "Add",
                onTap: () {
                  print("Add button clicked!");
                },
              ),
              SizedBox(height: 10),
              BeverageItemCard(
                imagePath: "lib/assets/images/bottle_four.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
                buttonText: "Add",
                onTap: () {
                  print("Add button clicked!");
                },
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
                    context.push("/payment");
                  },
                  child: const Text('Next(2 items)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
