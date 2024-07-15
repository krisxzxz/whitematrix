import 'package:fleett/backend/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'drivers_screen.dart';
import 'maintenance/maintenance_screen.dart';
import 'vehicles_screen.dart';
import 'trip_history_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late mongo.Db db;
  late mongo.DbCollection collection;

  int totalDrivers = 0;
  int totalVehicles = 0;
  int activeDrivers = 0;
  int activeVehicles = 0;
  int maintenanceCount = 0;

  @override
  void initState() {
    super.initState();
    _connectToDb();
  }

  Future<void> _connectToDb() async {
    db = mongo.Db(MONGO_URL);
    await db.open();
    collection = db.collection('your_collection_name');

    var drivers = await collection.findOne(mongo.where.eq('type', 'drivers'));
    var vehicles = await collection.findOne(mongo.where.eq('type', 'vehicles'));

    setState(() {
      totalDrivers = drivers?['total'] ?? 0;
      activeDrivers = drivers?['active'] ?? 0;
      totalVehicles = vehicles?['total'] ?? 0;
      activeVehicles = vehicles?['active'] ?? 0;
      maintenanceCount = vehicles?['maintenance'] ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(130)),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.menu,
                                                color: Colors.white),
                                            SizedBox(width: 3),
                                            Text("Hi",
                                                style:
                                                    GoogleFonts.leagueSpartan(
                                                        color: Colors.white,
                                                        fontSize: 24)),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 27.0),
                                          child: Text('Rakesh Khanna',
                                              style: GoogleFonts.leagueSpartan(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(Icons.person,
                                              color: Color(0xff1e283a)),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "Profile",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 30.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _buildInfoCard(
                                          'Drivers', totalDrivers.toString()),
                                      _buildInfoCard(
                                          'Vehicles', totalVehicles.toString()),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Fleet Overview',
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatusCard(
                              'Active Drivers', activeDrivers.toString()),
                          _buildStatusCard(
                              'Active Vehicles', activeVehicles.toString()),
                          _buildStatusCard(
                              'Maintenance', maintenanceCount.toString()),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildNavButton(
                                  context,
                                  'Vehicles',
                                  'lib/assets/icons/vehicle.png',
                                  VehiclesScreen(),
                                  height: 160),
                              SizedBox(width: 16),
                              _buildNavButton(
                                  context,
                                  'Maintenance',
                                  'lib/assets/icons/maintenance.png',
                                  MaintenanceScreen(),
                                  width: 170),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildNavButton(
                                  context,
                                  'Drivers',
                                  'lib/assets/icons/driver.png',
                                  DriversScreen(),
                                  width: 170),
                              SizedBox(width: 16),
                              _buildNavButton(
                                  context,
                                  'Trip History',
                                  'lib/assets/icons/client.png',
                                  TripHistoryScreen(),
                                  height: 160),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add_circle_sharp, color: Colors.white70, size: 30),
                  Icon(Icons.chat_bubble_rounded,
                      color: Colors.white70, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String count) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff1e283a), Color(0xff1e283a), Color(0xffd1d6de)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(75),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total ", style: GoogleFonts.poppins(color: Colors.white)),
            Text(title, style: GoogleFonts.poppins(color: Colors.white)),
            Text(count,
                style: GoogleFonts.karla(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(String title, String count) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1e283a),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.oxygen(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  value: 0.65,
                  color: Colors.white,
                  backgroundColor: Colors.green,
                  strokeWidth: 6,
                ),
              ),
              Text(
                count,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNavButton(
      BuildContext context, String title, String img, Widget? screen,
      {double width = 120, double height = 120}) {
    return InkWell(
      onTap: screen != null
          ? () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen))
          : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xff1e283a),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: GoogleFonts.oxygen(color: Colors.white, fontSize: 18)),
              SizedBox(height: 8),
              Image.asset(
                img,
                height: 60,
                width: 60,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
