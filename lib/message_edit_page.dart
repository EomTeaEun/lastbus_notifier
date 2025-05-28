import 'package:flutter/material.dart';

class MessageEditPage extends StatefulWidget {
  final String contactName;
  final String initialMessage;

  const MessageEditPage({
    super.key,
    required this.contactName,
    this.initialMessage = '',
  });

  @override
  State<MessageEditPage> createState() => _MessageEditPageState();
}

class _MessageEditPageState extends State<MessageEditPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialMessage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveMessage() {
    Navigator.pop(context, _controller.text);
  }

  void _clearMessage() {
    setState(() {
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.contactName}에게 보낼 메시지'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.delete), onPressed: _clearMessage),
          IconButton(icon: const Icon(Icons.check), onPressed: _saveMessage),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: _controller,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: '보낼 메시지를 작성해주세요.',
            filled: true,
            fillColor: Colors.blue.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
