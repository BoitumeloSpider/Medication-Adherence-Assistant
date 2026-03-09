class ChatMessage {
  final String message;
  final bool isUser;
  final Map<String, dynamic>? disease; // <-- this must be here

  ChatMessage({
    required this.message,
    required this.isUser,
    this.disease, // optional
  });
}