import 'package:flutter/material.dart';
import 'message_edit_page.dart';
import 'contact_add_page.dart';
class Contact {
  String name;
  String phone;
  bool isEnabled;
  String message;

  Contact({
    required this.name,
    required this.phone,
    this.isEnabled = false,
    this.message = '',
  });
}

class ContactManagePage extends StatefulWidget {
  const ContactManagePage({super.key});

  @override
  State<ContactManagePage> createState() => _ContactManagePageState();
}

class _ContactManagePageState extends State<ContactManagePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Contact> _contacts = [
    Contact(name: '엄마', phone: '010-1234-5678', isEnabled: true),
    Contact(name: '친구', phone: '010-0000-1234'),
    Contact(name: '아빠', phone: '010-0123-4567', isEnabled: true),
    Contact(name: '동생', phone: '010-1234-5678'),
  ];

  List<Contact> get _filteredContacts {
    final query = _searchController.text;
    if (query.isEmpty) return _contacts;
    return _contacts.where((c) =>
    c.name.contains(query) ||
        c.phone.replaceAll('-', '').contains(query)).toList();
  }

  void _editMessage(int index) async {
    final contact = _contacts[index];
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => MessageEditPage(
          contactName: contact.name,
          initialMessage: contact.message,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        contact.message = result;
      });
    }
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 연락처 관리'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // 연락처 추가 기능
              final newContact = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactAddPage()),
              );
              if (newContact != null && newContact is Map<String, String>) {
                setState(() {
                  _contacts.add(Contact(
                    name: newContact['name'] ?? '',
                    phone: newContact['phone'] ?? '',
                  ));
                });
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.blue.shade50,
                filled: true,
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.separated(
              itemCount: _filteredContacts.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                final originalIndex = _contacts.indexWhere(
                        (c) => c.name == contact.name && c.phone == contact.phone);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8), // 👉 오른쪽으로 이동
                          child: Text(
                            '${contact.name} (${contact.phone})',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Switch(
                              value: contact.isEnabled,
                              onChanged: (value) {
                                setState(() {
                                  contact.isEnabled = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 2),
                          InkWell(
                            onTap: () => _editMessage(originalIndex),
                            child: const Icon(Icons.edit_note,
                                size: 24, color: Colors.blueAccent),
                          ),
                          const SizedBox(width: 2),
                          InkWell(
                            onTap: () => _removeContact(originalIndex),
                            child: const Icon(Icons.delete_outline,
                                size: 22, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
