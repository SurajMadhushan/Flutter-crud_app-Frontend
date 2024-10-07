import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './signInScreen.dart';
import './userListScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
        style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Colors.blue[900], // Dark blue theme
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 207, 207, 207), // Light background for a professional look
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // User List Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListScreen()),
                );
              },
              child: Text('User List'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 58, 146), // Dark blue button
                foregroundColor: Colors.white, // White text color
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners for iOS-like design
                ),
              ),
            ),
            SizedBox(height: 16),

            // Add New User Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              child: Text('Add New User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 58, 146), // Dark blue button
                foregroundColor: Colors.white, // White text color
                padding: EdgeInsets.symmetric(vertical: 16.0),
                minimumSize: Size(double.infinity, 50), // Full width button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
            ),
            SizedBox(height: 32),

          
          ],
        ),
      ),
    );
  }
}
