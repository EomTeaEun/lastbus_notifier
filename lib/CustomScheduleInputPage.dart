// schedule_input_page.dart (업데이트된 새로운 노선 입력 페이지)
import 'package:flutter/material.dart';
import 'map_page.dart';

class CustomScheduleInputPage extends StatefulWidget {
  const CustomScheduleInputPage({super.key});

  @override
  State<CustomScheduleInputPage> createState() => _CustomScheduleInputPageState();
}

class _CustomScheduleInputPageState extends State<CustomScheduleInputPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  void _onComplete() {
    if (_titleController.text.isNotEmpty &&
        _departureController.text.isNotEmpty &&
        _destinationController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapPage(
            title: _titleController.text,
            departure: _departureController.text,
            destination: _destinationController.text,
          ),
        ),
      ).then((value) {
        if (value != null) {
          final schedule = '${_titleController.text} | ${_departureController.text}→${_destinationController.text}';
          Navigator.pop(context, schedule);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('일정 등록'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('제목', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '제목을 입력하세요.',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text('출발지', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _departureController,
              decoration: const InputDecoration(
                hintText: '출발지를 입력하세요.',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text('도착지', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                hintText: '도착지를 입력하세요.',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('취소'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: _onComplete,
                  child: const Text('완료'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
