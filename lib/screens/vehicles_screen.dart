import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'swift_detail_screen.dart';  // Import the new screen
import 'innova_detail_screen.dart';
import 'ertiga_detail_screen.dart';
class VehiclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e283a), Color(0xffD6D7DF), Color(0xff1e283a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 40.0), // Add this line
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text('Vehicles', style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  _buildVehicleCard(context, 'Swift', '200', 'Active'),
                  _buildVehicleCard(context, 'Innova', '200', 'Active'),
                  _buildVehicleCard(context, 'Ertiga', '200', 'Active'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, String name, String price, String status) {
    return GestureDetector(
      onTap: () {
        if (name == 'Swift') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SwiftDetailScreen()),
          );
        } else if (name == 'Innova') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InnovaDetailScreen()),
          );
        }
        else if (name == 'Ertiga') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ErtigaDetailScreen()),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0xff1e283a),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(child: Image.asset('lib/assets/images/$name.png', fit: BoxFit.cover), height: 160),
                Icon(Icons.favorite_border_outlined, color: Colors.white),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: GoogleFonts.mulish(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400)),
                      Text('License No.', style: GoogleFonts.mulish(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rs. $price", style: GoogleFonts.karla(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                      Text('2 Persons', style: GoogleFonts.karla(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(status, style: TextStyle(color: Colors.lightGreenAccent, fontSize: 15)),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }}
