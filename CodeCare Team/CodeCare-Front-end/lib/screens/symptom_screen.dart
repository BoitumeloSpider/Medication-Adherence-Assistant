import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/chatMessage.dart';
class HealthChatbotScreen extends StatefulWidget {
  const HealthChatbotScreen({super.key});

  @override
  State<HealthChatbotScreen> createState() => _HealthChatbotScreenState();
}

class _HealthChatbotScreenState extends State<HealthChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  List<dynamic> diseases = [];
  Set<String> quickSymptoms = {};

  @override
  void initState() {
    super.initState();
    loadDiseases();
    _messages.add(ChatMessage(
        message: "Hi 👋 How can I help you with your health today?",
        isUser: false));
  }

  Future<void> loadDiseases() async {
    final String response =
    await rootBundle.loadString('assets/data/diseases.json');
    final data = json.decode(response);
    setState(() {
      diseases = data["diseases"];

      // Build unique quick symptom buttons
      for (var disease in diseases) {
        for (var symptom in disease["symptoms"]) {
          quickSymptoms.add(symptom);
        }
      }
    });
  }

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(message: userMessage, isUser: true));
      _controller.clear();
    });

    final botMessage = await _getBotResponse(userMessage);

    setState(() {
      _messages.add(botMessage);
    });

    // Auto scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<ChatMessage> _getBotResponse(String userMessage) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
    final message = userMessage.toLowerCase();

    // Greeting
    if (message.contains("hi") || message.contains("hello")) {
      return ChatMessage(
          message: "Hi 👋 How can I help you with your health today?",
          isUser: false);
    }

    // Search diseases by symptom
    for (var disease in diseases) {
      final List<String> diseaseSymptoms = List<String>.from(disease["symptoms"]);
      for (var symptom in diseaseSymptoms) {
        // Normalize symptom
        final normalizedSymptom = symptom.toLowerCase().trim();
        // Check if user message contains symptom
        if (message.contains(normalizedSymptom)) {
          final botMsg =
              "I found information that may help regarding '${disease["name"]}'";
          return ChatMessage(message: botMsg, isUser: false, disease: disease);
        }
      }
    }

    return ChatMessage(
        message:
        "I couldn't find information about that symptom. Please consult a healthcare professional.",
        isUser: false);
  }

  Color _severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return Colors.red.shade300;
      case 'medium':
        return Colors.orange.shade300;
      case 'low':
        return Colors.green.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  Widget _quickSymptomButton(String symptom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          _controller.text = symptom;
          _sendMessage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1F6F68),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          symptom,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Advice Chatbot"),
        backgroundColor: const Color(0xFF1F6F68),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];

                // Bot message with disease card
                if (msg.disease != null) {
                  final disease = msg.disease!;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg.message,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        const SizedBox(height: 5),
                        Card(
                          color: _severityColor(disease["severity"]),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Disease: ${disease["name"]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 5),
                                Text("Description: ${disease["description"]}"),
                                const SizedBox(height: 5),
                                Text("Advice: ${disease["advice"]}"),
                                const SizedBox(height: 5),
                                Text("Prevention: ${disease["prevention"]}"),
                                const SizedBox(height: 5),
                                Text("Severity: ${disease["severity"]}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Normal chat bubble
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  alignment:
                  msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: msg.isUser ? Colors.green.shade200 : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: Radius.circular(msg.isUser ? 15 : 0),
                        bottomRight: Radius.circular(msg.isUser ? 0 : 15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(2, 2),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      msg.message,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),

          // Quick symptom buttons
          Container(
            color: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: quickSymptoms
                    .map((s) => _quickSymptomButton(s))
                    .toList(),
              ),
            ),
          ),

          const Divider(height: 1),
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your symptom...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF1F6F68)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}