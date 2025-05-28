// schedule_input_page.dart (업데이트된 새로운 노선 입력 페이지)
import 'package:flutter/material.dart';

class CustomScheduleInputPage extends StatefulWidget {
  const CustomScheduleInputPage({super.key});

  @override
  State<CustomScheduleInputPage> createState() => _CustomScheduleInputPageState();
}

class _CustomScheduleInputPageState extends State<CustomScheduleInputPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _busController = TextEditingController();

  final List<String> _stops = [
    '전자디자인고',
    '북대전 IC 네거리',
    '테크노밸리 2단지',
    '테크노밸리 5단지',
    '관평중학교',
    '롯데마트 대덕점',
  ];

  final List<Map<String, String>> _existingRoutes = [
    {
      'title': '개강총회',
      'bus': '704',
      'route': '충남대학교 정문 → 테크노밸리 5단지'
    },
    {
      'title': '동아리 회식',
      'bus': '1002',
      'route': '둔산동 → 주연이네'
    },
    {
      'title': '스터디 모임',
      'bus': '301',
      'route': '관평중학교 → 롯데마트 대덕점'
    },
  ];

  String? _departure;
  String? _destination;
  bool _showStopFields = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // 자동으로 "새로운 경로" 탭으로 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.animateTo(1);
    });
  }

  void _onSearchPressed() {
    if (_busController.text.trim().isNotEmpty) {
      setState(() {
        _showStopFields = true;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainBlue = const Color(0xFF0D99FF);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainBlue,
          title: const Text('노선 등록'),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: '기존 경로'),
              Tab(text: '새로운 경로'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // 기존 노선 목록 탭
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _existingRoutes.length,
              itemBuilder: (context, index) {
                final route = _existingRoutes[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      '${route['title']} | ${route['bus']} ${route['route']}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context, '${route['title']} | ${route['bus']} ${route['route']}');
                    },
                  ),
                );
              },
            ),
            // 새로운 경로 입력 탭
            SingleChildScrollView(
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
                  const Text('버스 번호', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _busController,
                          decoration: const InputDecoration(
                            hintText: '예: 704',
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: _onSearchPressed,
                        child: const Text('검색'),
                      ),
                    ],
                  ),
                  if (_showStopFields) ...[
                    const SizedBox(height: 24),
                    const Text('출발지', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      value: _departure,
                      hint: const Text('출발지를 선택하세요'),
                      items: _stops
                          .map((stop) => DropdownMenuItem(value: stop, child: Text(stop)))
                          .toList(),
                      onChanged: (value) => setState(() => _departure = value),
                    ),
                    const SizedBox(height: 24),
                    const Text('도착지', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      value: _destination,
                      hint: const Text('도착지를 선택하세요'),
                      items: _stops
                          .map((stop) => DropdownMenuItem(value: stop, child: Text(stop)))
                          .toList(),
                      onChanged: (value) => setState(() => _destination = value),
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
                          onPressed: () {
                            if (_titleController.text.isNotEmpty &&
                                _busController.text.isNotEmpty &&
                                _departure != null &&
                                _destination != null) {
                              final schedule =
                                  '${_titleController.text} | ${_busController.text} $_departure→$_destination';
                              Navigator.pop(context, schedule);
                            }
                          },
                          child: const Text('완료'),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
