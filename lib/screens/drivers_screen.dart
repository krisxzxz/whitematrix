import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DriversScreen extends StatelessWidget {
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
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  _buildDriverCard(
                      context,
                      'Ravi Varun',
                      'lib/assets/images/ravi.png',
                      '24/08/24',
                      '14/02/14',
                      'deets.pdf',
                      10,
                      'ravi_username',
                      'ravi_password',
                      '9876543210',
                      'Location A',
                      'PIN123',
                      'LIC12345',
                      '24/08/30',
                      'Good driver'),
                  _buildDriverCard(
                      context,
                      'Andy Wilson',
                      'lib/assets/images/andy.png',
                      '01/06/22',
                      '10/05/15',
                      'deets_andy.pdf',
                      20,
                      'andy_username',
                      'andy_password',
                      '9876543211',
                      'Location B',
                      'PIN124',
                      'LIC12346',
                      '01/06/31',
                      'Punctual driver'),
                  _buildDriverCard(
                      context,
                      'Tanya Ravi',
                      'lib/assets/images/tanya.png',
                      '15/11/23',
                      '08/03/16',
                      'deets_tanya.pdf',
                      15,
                      'tanya_username',
                      'tanya_password',
                      '9876543212',
                      'Location C',
                      'PIN125',
                      'LIC12347',
                      '15/11/32',
                      'Friendly driver'),
                  _buildDriverCard(
                      context,
                      'Jade Thomas',
                      'lib/assets/images/jade.png',
                      '20/02/25',
                      '12/07/17',
                      'deets_jade.pdf',
                      8,
                      'jade_username',
                      'jade_password',
                      '9876543213',
                      'Location D',
                      'PIN126',
                      'LIC12348',
                      '20/02/33',
                      'Careful driver'),
                  _buildDriverCard(
                      context,
                      'Aiswarya',
                      'lib/assets/images/ais.png',
                      '30/09/21',
                      '15/01/13',
                      'deets_ais.pdf',
                      25,
                      'ais_username',
                      'ais_password',
                      '9876543214',
                      'Location E',
                      'PIN127',
                      'LIC12349',
                      '30/09/29',
                      'Experienced driver'),
                ],
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
      String joiningDate,
      String licenseDate,
      String licenseDetails,
      int tripsTaken,
      String username,
      String password,
      String mobileNumber,
      String location,
      String driverPin,
      String licenseNumber,
      String licenseExpiryDate,
      String notes) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DriverDetailsScreen(
              name: name,
              imagePath: imagePath,
              joiningDate: joiningDate,
              licenseDate: licenseDate,
              licenseDetails: licenseDetails,
              tripsTaken: tripsTaken,
              username: username,
              password: password,
              mobileNumber: mobileNumber,
              location: location,
              driverPin: driverPin,
              licenseNumber: licenseNumber,
              licenseExpiryDate: licenseExpiryDate,
              notes: notes,
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
                    child: Image.asset(
                      imagePath,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    name,
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

class DriverDetailsScreen extends StatelessWidget {
  final String name;
  final String imagePath;
  final String joiningDate;
  final String licenseDate;
  final String licenseDetails;
  final int tripsTaken;
  final String username;
  final String password;
  final String mobileNumber;
  final String location;
  final String driverPin;
  final String licenseNumber;
  final String licenseExpiryDate;
  final String notes;

  DriverDetailsScreen({
    required this.name,
    required this.imagePath,
    required this.joiningDate,
    required this.licenseDate,
    required this.licenseDetails,
    required this.tripsTaken,
    required this.username,
    required this.password,
    required this.mobileNumber,
    required this.location,
    required this.driverPin,
    required this.licenseNumber,
    required this.licenseExpiryDate,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Details', style: GoogleFonts.mulish()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e283a), Color(0xffD6D7DF), Color(0xff1e283a)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(imagePath),
                ),
                SizedBox(height: 20),
                Text(
                  name,
                  style: GoogleFonts.mulish(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Color(0xff1e283a),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date of Joining : $joiningDate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'License Issued : $licenseDate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Details of License : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle license details tap
                            },
                            child: Row(
                              children: [
                                Icon(Icons.picture_as_pdf, color: Colors.white),
                                SizedBox(width: 5),
                                Text(
                                  licenseDetails,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Total Trips taken : $tripsTaken',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Username : $username',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Password : $password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mobile Number : $mobileNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Location : $location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Driver PIN : $driverPin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'License Number : $licenseNumber',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'License Expiry Date : $licenseExpiryDate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Notes : $notes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
