// lib/services/user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  // Method to add a new user
  Future<bool> addUser(User user) async {
    final url = Uri.parse(
        'http://192.168.8.191:8080/addUser'); // Adjust your API endpoint here

    try {
      // Make POST request to the server
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson()), // Convert the user object to JSON
      );

      if (response.statusCode == 201) {
        // Successfully added the user
        print("user added");
        return true;
      } else {
        // Something went wrong, print the error message
        print('Failed to add user: ${response.body}');
        return false;
      }
    } catch (error) {
      // Catch and print any error that occurred during the request
      print('Error adding user: $error');
      return false;
    }
  }

  // get all users

  Future<List<ViewUser>> getUsers() async {
    final String baseUrl2 = 'http://192.168.8.191:8080/getUsers';

    final url2 = Uri.parse(baseUrl2);
    try {
      final response = await http.get(url2);
      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> userListJson = jsonDecode(response.body);

        // Check if the user list is parsed correctly
        print('Parsed JSON: $userListJson');

        return userListJson.map((json) => ViewUser.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error occured: $e");
      return [];
    }
  }

  // delete user

  final String apiUrl =
      'http://192.168.8.191:8080/deleteUser'; // Replace with your actual API URL

  // Method to delete a user by their ID
  Future<bool> deleteUser(int userId) async {
    final url = Uri.parse('$apiUrl/$userId');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("Deleted successfully");
        return true; // Deletion successful
      } else {
        print('Failed to delete user. Status code: ${response.statusCode}');
        return false; // Failed to delete user
      }
    } catch (e) {
      print('Error occurred while deleting user: $e');
      return false; // Return false in case of an error
    }
  }



  // update user

   final String apiUrl3 = 'http://192.168.8.191:8080/updateUser'; // Replace with your actual API endpoint

  // Method to update user using PATCH
  Future<bool> updateUser(ViewUser user) async {
    final url = Uri.parse('$apiUrl3/${user.userId}'); // The API URL including the user ID

    try {
      // Create the body with the updated user details
      final body = jsonEncode({
       
        'userName': user.username,
        'email': user.email,
        'jobRole': user.jobRole,
        // You can exclude 'passwordHash' if it’s not being updated
      });

      // Send a PATCH request to update the user
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
           // Add authorization if needed
        },
        body: body,
      );

      // Check if the request was successful (status code 200 indicates success)
      if (response.statusCode == 200) {
        return true; // User updated successfully
      } else {
        print('Failed to update user: ${response.body}');
        return false; // Failed to update user
      }
    } catch (e) {
      print('Error occurred while updating user: $e');
      return false; // An error occurred
    }
  }
}
