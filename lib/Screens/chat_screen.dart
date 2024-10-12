import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../services/fetch_ai_screen.dart'; // Updated import name

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FetchAIService _fetchAIService = FetchAIService();
  List<types.Message> _messages = [];
  final _user = types.User(id: 'user');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    final welcomeMessage = types.TextMessage(
      author: types.User(id: 'agent'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: 'welcome',
      text: 'Hello! How can I assist you with pets today?',
    );
    setState(() {
      _messages.insert(0, welcomeMessage);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    if (message.text.isEmpty) return;

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
      _isLoading = true;
    });

    _fetchAIService.sendMessage(message.text).then((agentResponse) {
      final agentMessage = types.TextMessage(
        author: types.User(id: 'agent'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: agentResponse,
      );

      setState(() {
        _messages.insert(0, agentMessage);
        _isLoading = false;
      });
    }).catchError((error) {
      final errorMessage = types.TextMessage(
        author: types.User(id: 'agent'),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text:
            'Sorry, I could not process your request. Please try again later.',
      );

      setState(() {
        _messages.insert(0, errorMessage);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
            ),
          ),
          if (_isLoading) // Show loading indicator
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
