import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb; // For platform detection

void main() {
  runApp(const RafikiAIApp());
}

class RafikiAIApp extends StatelessWidget {
  const RafikiAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rafiki AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final String _clientId = 'anonymous'; // Or use student ID/phone
  final List<Map<String, String>> _chatHistory = []; // ChatGPT-like history

  bool _isLoading = false;

  // Determine backend URL based on platform (web or Android)
  String get _backendUrl {
    if (kIsWeb) {
      return 'http://localhost:5000';
    } else {
      return 'http://10.0.2.2:5000'; // Android emulator IP
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHistory();

    // Optional: Disable polling to reduce load and prevent interference (re-enable if needed for real-time updates)
    // _pollingTimer = Timer.periodic(Duration(seconds: 5), (timer) {
    //   _fetchHistory().catchError((e) {
    //     print('Polling error, stopping: $e');
    //     timer.cancel();  // Stop polling if errors persist
    //   });
    // });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    // _pollingTimer?.cancel();  // Remove if polling is disabled
    super.dispose();
  }

  // Fetch message history (optional, disable polling if not needed)
  Future<void> _fetchHistory() async {
    try {
      final uri = Uri.parse('$_backendUrl/api/history?client_id=$_clientId');
      print('Fetching history from: $uri'); // Debug log
      final response =
          await http.get(uri).timeout(Duration(seconds: 10)); // Add timeout

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final history = data['history'] as List<dynamic>;

        setState(() {
          _chatHistory.clear();
          for (var message in history) {
            _chatHistory.add({
              'role': message['role'] as String,
              'content': message['query'] as String,
            });
          }
        });
      } else {
        print('Failed to fetch history: Status ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching history: $e');
    }
  }

  // Send message to backend
  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
      _chatHistory.add({
        'role': 'user',
        'content': text,
      });

      // Add temporary loading message
      _chatHistory.add({
        'role': 'assistant',
        'content': '...',
        'isLoading': 'true',
      });
    });

    _textController.clear();
    _scrollToBottom();

    try {
      final uri = Uri.parse('$_backendUrl/api/chat');
      print('Sending message to: $uri'); // Debug log
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'message': text,
              'client_id': _clientId,
            }),
          )
          .timeout(Duration(seconds: 10)); // Add timeout

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final responseText = data['response'] as String;

        // Update history immediately (no delay)
        setState(() {
          _chatHistory.removeLast();
          _chatHistory.add({
            'role': 'assistant',
            'content': responseText,
          });
          _isLoading = false;
        });
      } else {
        setState(() {
          _chatHistory.removeLast(); // Remove loading
          _chatHistory.add({
            'role': 'assistant',
            'content':
                'Sorry, I had trouble processing that request. Status: ${response.statusCode}',
          });
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _chatHistory.removeLast(); // Remove loading
        _chatHistory.add({
          'role': 'assistant',
          'content': 'Network error. Please check your connection. Error: $e',
        });
        _isLoading = false;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 100), // Reduced for faster scrolling
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rafiki AI Counselor'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchHistory,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8.0),
              itemCount: _chatHistory.length,
              itemBuilder: (context, index) {
                final message = _chatHistory[index];
                final isUser = message['role'] == 'user';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isUser) ...[
                        CircleAvatar(
                          backgroundColor: Colors.purple.shade300,
                          child:
                              Text('R', style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.blue.shade100
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: message['isLoading'] == 'true'
                              ? SizedBox(
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      '...',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : Text(
                                  message['content'] ?? '',
                                  style: TextStyle(fontSize: 16),
                                ),
                        ),
                      ),
                      if (isUser) ...[
                        SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade300,
                          child:
                              Text('U', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(12),
                    ),
                    enabled: !_isLoading,
                    onSubmitted:
                        _isLoading ? null : (value) => _sendMessage(value),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isLoading
                      ? null
                      : () => _sendMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
