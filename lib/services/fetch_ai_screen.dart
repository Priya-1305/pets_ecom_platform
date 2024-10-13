import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FetchAIService {
  // Use the actual IP address of your local machine if running on a physical device/emulator
  final String _apiUrl = 'http://192.168.1.69:5002/api/chat/';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'query': message}), // Ensure you send 'query'
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData[
            'response']; // Adjust this based on your API response
      } else {
        throw Exception(
            'Failed to load response, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to communicate with AI');
    }
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String _responseMessage = "";
  final FetchAIService _fetchAIService = FetchAIService();

  void _sendMessage() async {
    final message = _controller.text;
    if (message.isEmpty) {
      return;
    }

    try {
      final response = await _fetchAIService.sendMessage(message);
      setState(() {
        _responseMessage = response;
      });
    } catch (e) {
      setState(() {
        _responseMessage = "Error: Unable to send message";
      });
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with AI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
            SizedBox(height: 20),
            Text(
              _responseMessage,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ChatScreen(),
  ));
}
