import 'package:fleett/backend/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'driver_details_screen.dart';

class DriversScreen extends StatefulWidget {
  @override
  _DriversScreenState createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  List<Map<String, dynamic>> drivers = [];

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    var db = await mongo.Db.create(MONGO_URL);
    await db.open();
    var collection = db.collection('drivers');
    var result = await collection.find().toList();
    setState(() {
      drivers = result;
    });
    await db.close();
  }

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
            SizedBox(height: 40.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Drivers',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  var driver = drivers[index];
                  return _buildDriverCard(
                    context,
                    driver,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(BuildContext context, Map<String, dynamic> driver) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverDetailsScreen(
              name: driver['name'],
              imagePath: driver['imagePath'],
              joiningDate: driver['joiningDate'],
              licenseDate: driver['licenseDate'],
              licenseDetails: driver['licenseDetails'],
              tripsTaken: driver['tripsTaken'],
              username: driver['username'],
              password: driver['password'],
              mobileNumber: driver['mobileNumber'],
              location: driver['location'],
              driverPin: driver['driverPin'],
              licenseNumber: driver['licenseNumber'],
              licenseExpiryDate: driver['licenseExpiryDate'],
              notes: driver['notes'],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xff1e283a),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.network(
                      driver['imagePath'],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    driver['name'],
                    style: GoogleFonts.mulish(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.favorite_border_outlined, color: Colors.white),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Icon(Icons.arrow_forward_ios, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
