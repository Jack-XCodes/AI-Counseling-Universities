import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';

class ApiService {
  // // For web, we need to use localhost 
  // final String baseUrl = 'http://localhost:5000/api';
  final String baseUrl = 'http://10.0.2.2:5000/api';  // For Android emulator
  
  // Cache client ID in shared preferences
  Future<String> getClientId() async {
    final prefs = await SharedPreferences.getInstance();
    var clientId = prefs.getString('client_id');
    
    if (clientId == null) {
      // Generate a new client ID based on timestamp
      clientId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('client_id', clientId);
    }
    
    print('Using client ID: $clientId');
    return clientId;
  }
  
  // Send a message to the AI assistant
  Future<bool> sendMessage(String message) async {
    try {
      final clientId = await getClientId();
      print('Sending message to $baseUrl/chat');
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'client_id': clientId,
        }),
      );
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Error sending message: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception sending message: $e');
      return false;
    }
  }
  
  // Get message history
  Future<ChatSession> getHistory() async {
    try {
      final clientId = await getClientId();
      print('Fetching history from $baseUrl/history?client_id=$clientId');
      final response = await http.get(
        Uri.parse('$baseUrl/history?client_id=$clientId'),
      );
      
      print('History response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ChatSession.fromJson(data);
      } else {
        print('Error fetching history: ${response.body}');
        return ChatSession.empty();
      }
    } catch (e) {
      print('Exception fetching history: $e');
      return ChatSession.empty();
    }
  }
  
  // Check if API is running
  Future<bool> checkHealth() async {
    try {
      print('Checking health at $baseUrl/health');
      final response = await http.get(Uri.parse('$baseUrl/health'));
      print('Health check status: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Health check failed: $e');
      return false;
    }
  }
  
  // Test API connection
  Future<String> testConnection() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/test'));
      if (response.statusCode == 200) {
        return 'Connection successful: ${response.body}';
      } else {
        return 'Connection failed with status ${response.statusCode}';
      }
    } catch (e) {
      return 'Connection error: $e';
    }
  }
}
