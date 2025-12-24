import 'dart:ui';
import 'package:flutter/material.dart';

class LiveChatSupportScreen extends StatefulWidget {
  const LiveChatSupportScreen({super.key});

  @override
  State<LiveChatSupportScreen> createState() => _LiveChatSupportScreenState();
}

class _LiveChatSupportScreenState extends State<LiveChatSupportScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const accentColor = Color(0xffFF620D);

  List<Map<String, dynamic>> messages = [
    {
      "text": "Hello! 👋 How can we assist you today?",
      "isUser": false,
      "time": "10:00 AM",
    },
    {
      "text": "I need help with my recent order.",
      "isUser": true,
      "time": "10:02 AM",
      "status": MessageStatus.read,
    },
  ];

  String _formattedTime() {
    final now = TimeOfDay.now();
    final hour =
    now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": _controller.text.trim(),
        "isUser": true,
        "time": _formattedTime(),
        "status": MessageStatus.sending,
      });
    });

    _controller.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        messages.last["status"] = MessageStatus.sent;
      });
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() {
        messages.last["status"] = MessageStatus.delivered;
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        messages.last["status"] = MessageStatus.read;
      });
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          "text": "Our support team will get back shortly 😊",
          "isUser": false,
          "time": _formattedTime(),
        });
      });
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Live Chat Support"),
        centerTitle: true,
        backgroundColor: accentColor.withOpacity(0.75),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1A1A1A),
              Color(0xff2A2A2A),
              Color(0xffFF620D),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: kToolbarHeight + 30),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final msg = messages[index];

                  return ChatBubble(
                    message: msg["text"],
                    time: msg["time"],
                    isUser: msg["isUser"],
                    status: msg["status"],
                  );
                },
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Type your message...",
                              hintStyle:
                              TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: sendMessage,
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: accentColor,
                            child: Icon(Icons.send,
                                color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///Chat Bubble


enum MessageStatus { sending, sent, delivered, read }

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isUser;
  final MessageStatus? status;
  final Color accentColor;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isUser,
    this.status,
    this.accentColor = const Color(0xffFF620D),
  });

  Widget _buildStatusIcon() {
    if (!isUser || status == null) return const SizedBox();

    switch (status!) {
      case MessageStatus.sending:
        return const Icon(Icons.access_time,
            size: 14, color: Colors.white54);
      case MessageStatus.sent:
        return const Icon(Icons.check,
            size: 14, color: Colors.white70);
      case MessageStatus.delivered:
        return const Icon(Icons.done_all,
            size: 16, color: Colors.white70);
      case MessageStatus.read:
        return const Icon(Icons.done_all,
            size: 16, color: Colors.lightBlueAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 260),
            decoration: BoxDecoration(
              color: isUser
                  ? accentColor.withOpacity(0.85)
                  : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft:
                isUser ? const Radius.circular(16) : Radius.zero,
                bottomRight:
                isUser ? Radius.zero : const Radius.circular(16),
              ),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.white70,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildStatusIcon(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
