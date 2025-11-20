import 'package:flutter/material.dart';

class LiveChatSupportScreen extends StatefulWidget {
  const LiveChatSupportScreen({super.key});

  @override
  State<LiveChatSupportScreen> createState() => _LiveChatSupportScreenState();
}

class _LiveChatSupportScreenState extends State<LiveChatSupportScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      "text": "Hello! 👋 How can we assist you today?",
      "isUser": false,
      "time": "10:00 AM"
    },
    {
      "text": "I need help with my recent order.",
      "isUser": true,
      "time": "10:02 AM"
    },
  ];

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": _controller.text.trim(),
        "isUser": true,
        "time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}"
      });
    });

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({
          "text": "Our support team will get back shortly 😊",
          "isUser": false,
          "time": "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}"
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Live Chat Support"),
          centerTitle: true,
          elevation: 1,
        ),

        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];

                  return Align(
                    alignment:
                    msg["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 250),
                      decoration: BoxDecoration(
                        color: msg["isUser"]
                            ? Color(0xffFF620D)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(14),
                          topRight: const Radius.circular(14),
                          bottomLeft:
                          msg["isUser"] ? const Radius.circular(14) : Radius.zero,
                          bottomRight:
                          msg["isUser"] ? Radius.zero : const Radius.circular(14),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 3,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: msg["isUser"]
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg["text"],
                            style: TextStyle(
                              color: msg["isUser"] ? Colors.white : Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg["time"],
                            style: TextStyle(
                              color: msg["isUser"]
                                  ? Colors.white70
                                  : Colors.grey.shade500,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 6,
                      color: Colors.black.withOpacity(0.08),
                      offset: const Offset(0, -1))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: sendMessage,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xffFF620D),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
