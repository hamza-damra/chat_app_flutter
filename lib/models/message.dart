class Message {
  final String? message;
  final String? sender;

  Message({required this.message, required this.sender});

  factory Message.fromJson(json) {
    return Message(
      message: json['message'] as String? ?? 'Null Message',
      sender: json['id'] as String? ?? 'Unknown Sender',
    );
  }
}
