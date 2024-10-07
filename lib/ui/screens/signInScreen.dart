import 'package:flutter/material.dart';
import '../../services/user_service.dart';
import '../../models/user.dart';
import './homeScreen.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedJobRole;

  // Job roles for the dropdown list
  final List<String> _jobRoles = ['Developer', 'Engineer', 'Manager'];

  // Create a global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Set default job role to the first in the list (Developer)
    _selectedJobRole = _jobRoles[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create User',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900], // Dark blue theme for the AppBar
      ),
      body: Container(
        color: Color.fromARGB(255, 207, 207, 207), // Light grey background
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach the global key to the Form
          child: SingleChildScrollView( // Allow scrolling for small screens
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
                    return null; // Return null if the input is valid
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
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 16),

                // Password Hash field (as normal password field)
                TextFormField(
                  controller: _passwordController,
                  obscureText: true, // To hide the password input
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 16),

                // Job Role Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Job Role',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedJobRole,
                  items: _jobRoles.map((String jobRole) {
                    return DropdownMenuItem<String>(
                      value: jobRole,
                      child: Text(jobRole),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedJobRole = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Job Role is required';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 16),

                // Create User Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) { // Validate form inputs
                      final UserService _userService = UserService();
                      // Handle user creation
                      print('Username: ${_usernameController.text}');
                      print('Password Hash: ${_passwordController.text}');
                      print('Selected Job Role: $_selectedJobRole');

                      User newUser = User(
                        username: _usernameController.text,
                        passwordHash: _passwordController.text,
                        email: _emailController.text,
                        jobRole: _selectedJobRole ?? 'Unknown', // Ensure job role is set
                      );

                      bool success = await _userService.addUser(newUser);

                      if (success) {
                        // Show success message or navigate to another screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User added successfully')),
                        );
                        Navigator.pop(context);
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add user')),
                        );
                      }
                    }
                  },
                  child: Text('Create'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 58, 146), // Dark blue button
                    foregroundColor: Colors.white, // White text color
                    minimumSize: Size(double.infinity, 50), // Full width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
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
