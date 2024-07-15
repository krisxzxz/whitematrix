import 'package:fleett/backend/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:fleett/screens/maintenance/battery_check.dart';
import 'package:fleett/screens/maintenance/brake_inspection_screen.dart';
import 'package:fleett/screens/maintenance/filter_replacement_screen.dart';
import 'package:fleett/screens/maintenance/oil_change_screen.dart';
import 'package:fleett/screens/maintenance/tire_change_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List<Map<String, dynamic>> maintenanceTasks = [];

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceTasks();
  }

  Future<void> _fetchMaintenanceTasks() async {
    try {
      var db = await mongo.Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection('maintenance_tasks');
      var data = await collection.find().toList();
      setState(() {
        maintenanceTasks = data;
      });
      await db.close();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

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
                      ...maintenanceTasks.map((task) {
                        return _buildMaintenanceCard(
                          context,
                          task['title'],
                          task['subtitle'],
                          task['imagePath1'],
                          task['imagePath2'],
                          task['route'],
                        );
                      }).toList(),
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
    String route,
  ) {
    return Card(
      color: Color(0xff1e283a),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imagePath1),
                radius: 18,
              ),
              Positioned(
                left: 25,
                child: CircleAvatar(
                  backgroundImage: AssetImage(imagePath2),
                  radius: 18,
                ),
              ),
            ],
          ),
        ),
        title: Text(title, style: GoogleFonts.oxygen(color: Colors.white, fontSize: 18)),
        subtitle: Text(subtitle, style: GoogleFonts.oxygen(color: Colors.white, fontSize: 14)),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _getScreen(route)),
          );
        },
      ),
    );
  }

  Widget _getScreen(String route) {
    switch (route) {
      case 'TireChangeScreen':
        return TireChangeScreen();
      case 'OilChangeScreen':
        return OilChangeScreen();
      case 'BrakeInspectionScreen':
        return BrakeInspectionScreen();
      case 'BatteryCheck':
        return BatteryCheck();
      case 'FilterReplacementScreen':
        return FilterReplacementScreen();
      default:
        return Container(); // Handle unknown route
    }
  }
}