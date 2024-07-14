import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fleett/screens/maintenance/battery_check.dart';
import 'package:fleett/screens/maintenance/brake_inspection_screen.dart';
import 'package:fleett/screens/maintenance/filter_replacement_screen.dart';
import 'package:fleett/screens/maintenance/oil_change_screen.dart';
import 'tire_change_screen.dart'; // Import the new screen

class MaintenanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1e283a),
        title: Text(
          'Maintenance',
          style: GoogleFonts.leagueSpartan(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1e283a),
              Color(0xffd1d6de),
              Color(0xffd1d6de),
              Color(0xff1e283a)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        '',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 20),
                      _buildMaintenanceCard(
                        context,
                        'Tire Change',
                        'Next tire change due in 3000 km',
                        'lib/assets/images/Ertiga.png',
                        'lib/assets/images/Innova.png',
                      ),
                      _buildMaintenanceCard(
                        context,
                        'Oil Change',
                        'Next oil change due in 5000 km',
                        'lib/assets/images/Ertiga.png',
                        'lib/assets/images/Innova.png',
                      ),
                      _buildMaintenanceCard(
                        context,
                        'Brake Inspection',
                        'Next inspection due in 2000 km',
                        'lib/assets/images/Swift.png', // Custom image for Brake Inspection
                        'lib/assets/images/Ertiga.png', // Custom image for Brake Inspection
                      ),
                      _buildMaintenanceCard(
                        context,
                        'Battery Check',
                        'Next check due in 4000 km',
                        'lib/assets/images/Swift.png', // Custom image for Battery Check
                        'lib/assets/images/Innova.png', // Custom image for Battery Check
                      ),
                      _buildMaintenanceCard(
                        context,
                        'Filter Replacement',
                        'Next replacement due in 6000 km',
                        'lib/assets/images/Ertiga.png',
                        'lib/assets/images/Innova.png',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceCard(
      BuildContext context,
      String title,
      String subtitle,
      String imagePath1,
      String imagePath2,
      ) {
    return Card(
      color: Color(0xff1e283a),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: SizedBox(
          width: 60, // Adjust width to make sure both avatars are visible
          child: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath1),
                radius: 18, // Adjust size to make them fit better
              ),
              Positioned(
                left: 25, // Adjust this value to control the overlap
                child: CircleAvatar(
                  backgroundImage: AssetImage(imagePath2),
                  radius: 18, // Adjust size to make them fit better
                ),
              ),
            ],
          ),
        ),
        title: Text(title, style: GoogleFonts.oxygen(color: Colors.white, fontSize: 18)),
        subtitle: Text(subtitle, style: GoogleFonts.oxygen(color: Colors.white, fontSize: 14)),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        onTap: () {
          if (title == 'Tire Change') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TireChangeScreen()),
            );
          } else if (title == 'Oil Change') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OilChangeScreen()),
            );
          } else if (title == 'Brake Inspection') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrakeInspectionScreen()),
            );
          } else if (title == 'Battery Check') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BatteryCheck()),
            );
          } else if (title == 'Filter Replacement') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterReplacementScreen()),
            );
          }
        },
      ),
    );
  }
}
