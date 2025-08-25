import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showCustomConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 300,
          decoration: ShapeDecoration(
            color: Colors.white.withValues(alpha: 0.17),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.23),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 10.47,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("lib/assets/icons/correct_icon.svg"),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Table Booked ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.75,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                    TextSpan(
                      text: 'Successfully',
                      style: TextStyle(
                        color: const Color(0xFFF7D99A),
                        fontSize: 16.75,
                        fontFamily: 'Segoe UI',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.52,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFF7D99A),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bob Smith',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.65,
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    '+1 6546 654 542',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.65,
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.52,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFF7D99A),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_month, color: Color(0xFFF7D99A)),
                  Text(
                    '17 December 2025 | 12:15 PM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.65,
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group, color: Color(0xFFF7D99A)),
                  Text(
                    '4 Guests',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.65,
                      fontFamily: 'Segoe UI',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              ],
             ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.52,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: const Color(0xFFF7D99A),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You saved \$5 on this Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.56,
                  fontFamily: 'Segoe UI',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
