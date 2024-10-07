import 'package:flutter/material.dart';
import '../../models/user.dart'; // Import your user model
import '../../services/user_service.dart'; // Import your user service
import './userDetailsScreen.dart';

class UpdateUserForm extends StatefulWidget {
  final ViewUser user; // The existing user to update

  UpdateUserForm({required this.user});

  @override
  _UpdateUserFormState createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _jobRoleController;

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with the current user data
    _usernameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _jobRoleController = TextEditingController(text: widget.user.jobRole);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _jobRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User',
        style: TextStyle(
          color: Colors.white,
        ),
        
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900], // Dark blue theme for the AppBar
      ),
      body: Container(
        color: Color.fromARGB(255, 207, 207, 207), // Light grey background
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Username field
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Job Role field
              TextFormField(
                controller: _jobRoleController,
                decoration: InputDecoration(
                  labelText: 'Job Role',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Job Role is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Update Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Update the user details
                      ViewUser updatedUser = ViewUser(
                        userId: widget.user.userId,
                        username: _usernameController.text,
                        email: _emailController.text,
                        jobRole: _jobRoleController.text,
                      );

                      // Call your update user service
                      bool success =
                          await UserService().updateUser(updatedUser);

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User updated successfully')),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(
                                      user: updatedUser,
                                    ))); // Go back after updating
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to update user')),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Update User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18, // Set the font size for button text
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900], // Dark blue for the button
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
