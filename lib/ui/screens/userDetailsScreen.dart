import 'package:crud_app/ui/screens/userListScreen.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart'; // Adjust the path according to your project structure
import '../../services/user_service.dart'; // Import your UserService to handle the deletion
import './updateUserScreen.dart';

class UserDetailsScreen extends StatelessWidget {
  final ViewUser user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900], // Dark blue theme for the AppBar
      ),
      body: Container(
        color: Color.fromARGB(255, 207, 207, 207), // Light grey background
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Text(
                  user.username[0].toUpperCase(),
                  style: TextStyle(fontSize: 40),
                ),
                backgroundColor: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 24),

            // User Information
            buildUserDetailItem('Username', user.username),
            Divider(),
            buildUserDetailItem('Email', user.email),
            Divider(),
            buildUserDetailItem('Job Role', user.jobRole),
            Divider(),
            buildUserDetailItem('UserId', user.userId.toString()),

            SizedBox(height: 24),

            // Delete User Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Show confirmation dialog before deletion
                  final confirmation = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete User'),
                        content: Text('Are you sure you want to delete this user?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirmation == true) {
                    // Call the delete method from UserService
                    final userService = UserService();
                    bool success = await userService.deleteUser(user.userId);

                    if (success) {
                      // Show success message and navigate back
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User deleted successfully')),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => UserListScreen()),
                      );
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete user')),
                      );
                    }
                  }
                },
                child: Text(
                  'Delete User',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 223, 15, 0), // Red background for delete
                  minimumSize: Size(150, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Update User Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUserForm(user: user),
                    ),
                  );
                },
                child: Text(
                  'Update User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Text size for the button
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 58, 146), // Dark blue for update
                  minimumSize: Size(150, 50), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build the user detail widgets
  Widget buildUserDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis, // Prevent text overflow
            ),
          ),
        ],
      ),
    );
  }
}
