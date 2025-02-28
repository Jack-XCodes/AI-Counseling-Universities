class ChatMessage {
  final String id;
  final String text;
  final String role; // 'user' or 'assistant'
  final String timestamp;
  final bool isTyping;

  ChatMessage({
    required this.id, 
    required this.text, 
    required this.role,
    required this.timestamp,
    this.isTyping = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['timestamp'] ?? DateTime.now().toIso8601String(),
      text: json['query'] ?? '',
      role: json['role'] ?? 'user',
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'query': text,
      'role': role,
    };
  }
}

class ChatSession {
  final String clientId;
  final List<ChatMessage> messages;

  ChatSession({
    required this.clientId,
    required this.messages,
  });

  factory ChatSession.empty() {
    return ChatSession(
      clientId: DateTime.now().millisecondsSinceEpoch.toString(),
      messages: [],
    );
  }

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    List<dynamic> historyJson = json['history'] ?? [];
    List<ChatMessage> messages = historyJson
        .map((msg) => ChatMessage.fromJson(msg))
        .toList();

    return ChatSession(
      clientId: json['client_id'] ?? 'anonymous',
      messages: messages,
    );
  }
}
