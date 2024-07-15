import 'package:fleett/backend/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class VehiclesScreen extends StatefulWidget {
  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  List<Map<String, dynamic>> vehicles = [];

  @override
  void initState() {
    super.initState();
    _fetchVehiclesData();
  }

  Future<void> _fetchVehiclesData() async {
    try {
      var db = await mongo.Db.create(MONGO_URL);
      await db.open();
      var collection = db.collection(VEHICLE_COLLECTION);
      var data = await collection.find().toList();
      setState(() {
        vehicles = data;
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
                Text('Vehicles',
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  var vehicle = vehicles[index];
                  return _buildVehicleCard(context, vehicle);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleCard(BuildContext context, Map<String, dynamic> vehicle) {
    String name = vehicle['name'];
    String price = vehicle['price'].toString();
    String status = vehicle['status'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleDetailScreen(vehicle: vehicle),
          ),
        );
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
                Container(
                  child: Image.network(vehicle['image_url'], fit: BoxFit.cover),
                  height: 160,
                ),
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
                      Text(name,
                          style: GoogleFonts.mulish(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w400)),
                      Text('License No.',
                          style: GoogleFonts.mulish(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rs. $price",
                          style: GoogleFonts.karla(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300)),
                      Text('2 Persons',
                          style: GoogleFonts.karla(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
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
                  Text(status,
                      style: TextStyle(
                          color: Colors.lightGreenAccent, fontSize: 15)),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VehicleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  VehicleDetailScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e283a), Color(0xffd1d6de), Color(0xff1e283a)],
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
                Text(vehicle['name'],
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Image.network(
                            vehicle[
                                'image_url'], // Image URL from the vehicle data
                            height: 250,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Features',
                                  style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildFeatureCard('manual', Icons.drive_eta),
                                  _buildFeatureCard(
                                      '6 seats', Icons.event_seat),
                                  _buildFeatureCard(
                                      '6.4L', Icons.local_gas_station),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Maintenance',
                                  style: GoogleFonts.mulish(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildStatusCard('Wiper Status', '57%'),
                                  _buildStatusCard('Oil Change', '86%'),
                                  _buildStatusCard('Tire Repair', '27%'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add navigation or functionality here if needed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff1e283a),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Text('Maintenance History',
                                  style: GoogleFonts.mulish(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String title, IconData icon) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xff1e283a),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 45),
            SizedBox(height: 10),
            Text(title,
                style: GoogleFonts.mulish(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String status) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xff1e283a),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: GoogleFonts.mulish(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            Container(
              width: 80,
              child: LinearProgressIndicator(
                value: double.parse(status.replaceAll('%', '')) / 100,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            SizedBox(height: 10),
            Text(status,
                style: GoogleFonts.mulish(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
