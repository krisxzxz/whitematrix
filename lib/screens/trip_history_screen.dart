import 'package:fleett/backend/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class TripHistoryScreen extends StatefulWidget {
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  List<Map<String, dynamic>> tripHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchTripHistoryData();
  }

  Future<void> _fetchTripHistoryData() async {
    try {
      var db = await mongo.Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(TRIP_COLLECTION);
      var data = await collection.find().toList();
      setState(() {
        tripHistory = data;
      });
      await db.close();
    } catch (e) {
      print("Error fetching data: $e");
    }
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
                  'Trip History',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: tripHistory.length,
                itemBuilder: (context, index) {
                  var trip = tripHistory[index];
                  return _buildDriverCard(
                    context,
                    trip['driverName'],
                    trip['driverImagePath'],
                    trip['vehicleImagePath'],
                    trip['joiningDate'],
                    trip['licenseDate'],
                    trip['licenseDetails'],
                    trip['tripsTaken'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverCard(
    BuildContext context,
    String name,
    String imagePath,
    String vehicleImagePath,
    String joiningDate,
    String licenseDate,
    String licenseDetails,
    int tripsTaken,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardHeight = constraints.maxWidth * 0.3;
        double imageRadius = constraints.maxWidth * 0.08;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            color: Color(0xff1e283a),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Positioned(
                top: constraints.maxWidth * 0.02,
                left: constraints.maxWidth * 0.02,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: imageRadius,
                      backgroundImage: AssetImage(vehicleImagePath),
                    ),
                    Transform.translate(
                      offset:
                          Offset(-imageRadius * 0.8, 0), // Adjust the overlap
                      child: CircleAvatar(
                        radius: imageRadius,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: constraints.maxWidth * 0.02,
                left: imageRadius * 4.0, // Kept the text position same
                child: Text(
                  name,
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: constraints.maxWidth * 0.04,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                top: constraints.maxWidth * 0.12,
                left: imageRadius * 4.0, // Kept the text position same
                child: Row(
                  children: [
                    Text(
                      'Status: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                    Text(
                      'Approved',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: constraints.maxWidth * 0.02,
                left: imageRadius * 4.0, // Kept the text position same
                child: Row(
                  children: [
                    Text(
                      'From: $joiningDate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02),
                    Text(
                      'To: $licenseDate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: constraints.maxWidth * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
