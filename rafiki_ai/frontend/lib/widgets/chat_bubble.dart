import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../models/message.dart';
import '../theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showAvatar;

  const ChatBubble({
    super.key,
    required this.message,
    this.showAvatar = true,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';
    
    String displayText = message.text;
    if (!isUser && displayText.startsWith('Rafiki:')) {
      displayText = displayText.substring(7).trim();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser && showAvatar)
            CircleAvatar(
              backgroundColor: RafikiTheme.primaryColor,
              radius: 18,
              child: Text(
                'R',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          
          if (!isUser && showAvatar) SizedBox(width: 8),
          
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser ? RafikiTheme.userBubbleColor : RafikiTheme.aiBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isUser ? 16 : 0),
                  topRight: Radius.circular(isUser ? 0 : 16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: message.isTyping
                  ? SizedBox(
                      width: 40,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            '...',
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: RafikiTheme.primaryColor,
                            ),
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                    )
                  : Text(
                      displayText,
                      style: TextStyle(
                        fontSize: 16,
                        color: RafikiTheme.textPrimary,
                      ),
                    ),
            ),
          ),
          
          if (isUser && showAvatar) SizedBox(width: 8),
          
          if (isUser && showAvatar)
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 18,
              child: Icon(
                Icons.person,
                color: Colors.grey.shade700,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}

// Group messages from the same sender
class ChatBubbleGroup extends StatelessWidget {
  final List<ChatMessage> messages;
  
  const ChatBubbleGroup({super.key, required this.messages});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: messages.asMap().entries.map((entry) {
        final index = entry.key;
        final message = entry.value;
        final showAvatar = index == 0 || index == messages.length - 1;
        
        return ChatBubble(
          message: message,
          showAvatar: showAvatar,
        );
      }).toList(),
    );
  }
}