import 'package:flutter/material.dart';

class ContactAddPage extends StatefulWidget {
  const ContactAddPage({super.key});

  @override
  State<ContactAddPage> createState() => _ContactAddPageState();
}

class _ContactAddPageState extends State<ContactAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();

  void _submit() {
    if (_nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'relation': _relationController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('연락처 등록'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('완료', style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                const SizedBox(width: 24),
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.tag_faces, size: 36),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          hintText: '이름',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Text('대전광역시 거주', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('전화번호'),
            trailing: SizedBox(
              width: 150,
              child: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  hintText: '010-1234-0000',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('관계'),
            trailing: SizedBox(
              width: 100,
              child: TextField(
                controller: _relationController,
                decoration: const InputDecoration(
                  hintText: '친구',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
