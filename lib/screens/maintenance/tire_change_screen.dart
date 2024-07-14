import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TireChangeScreen extends StatelessWidget {
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
                  _buildVehicleCard(context, 'Innova', '', 'Undone'),
                  _buildVehicleCard(context, 'Ertiga', '', 'Undone'),
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
                      Text(" $price", style: GoogleFonts.karla(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300)),
                      Text('', style: GoogleFonts.karla(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300)),
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
                  Text(status, style: TextStyle(color: Colors.red, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }}
