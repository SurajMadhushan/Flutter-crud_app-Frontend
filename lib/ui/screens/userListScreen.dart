// lib/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import './userDetailsScreen.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<ViewUser>> _userList;

  @override
  void initState() {
    super.initState();
    _userList = UserService().getUsers(); // Fetch the user list from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User List',
          style: TextStyle(color: Colors.white), // White text color
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900], // Dark blue theme
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromARGB(255, 207, 207, 207), // Light background color
        child: FutureBuilder<List<ViewUser>>(
          future: _userList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Show loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching users'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No users found'));
            }

            // Display the list of users
            List<ViewUser> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(user: user),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(user.username[0].toUpperCase()),
                        backgroundColor: Colors.blueAccent,
                      ),
                      title: Text(
                        user.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Black text for username
                        ),
                      ),
                      subtitle: Text(
                        user.email,
                        style: TextStyle(color: Colors.grey[700]), // Subtitle color
                      ),
                      trailing: Text(
                        user.jobRole,
                        style: TextStyle(color: Colors.grey[600]), // Job role color
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
