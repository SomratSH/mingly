import 'package:flutter/material.dart';
import 'package:mingly/src/screens/protected/my_bottles/widget/my_bottle_card.dart';

class MyBottlesHistoryScreen extends StatelessWidget {
  const MyBottlesHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: const Text(
          'My Bottles History',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
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
                      color: Color(0xFFCBAA69),
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
              SizedBox(height: 30,),
           MyBottleCard(
                imagePath: "lib/assets/images/bottle_one.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
               
              ),
              SizedBox(height: 10),
              MyBottleCard(
                imagePath: "lib/assets/images/bottle_two.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
               
              ),
              SizedBox(height: 10),
              MyBottleCard(
                imagePath: "lib/assets/images/bottle_three.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
               
              ),
              SizedBox(height: 10),
              MyBottleCard(
                imagePath: "lib/assets/images/bottle_four.jpg",
                title: "3 Champagne",
                number: "No.123",
                keepingDate: "12 Jan 2025",
                expiryDate: "12 Dec 2025",
               
              ),
        ],
      )
    );
  }
}