import 'package:flutter/material.dart';

class AddFavoriteRoute extends StatefulWidget {
  const AddFavoriteRoute({super.key});

  @override
  State<AddFavoriteRoute> createState() => _AddFavoriteRoutePageState();
}

class _AddFavoriteRoutePageState extends State<AddFavoriteRoute> {
  final List<String> _stations = [
    '충남대학교 정문',
    '테크노밸리 5단지',
    '전자디자인고',
    '북대전 IC 네거리',
    '테크노밸리 2단지',
    '관평중학교',
    '롯데마트 대덕점'
  ];

  final TextEditingController _busSearchController = TextEditingController();
  String? _selectedDeparture;
  String? _selectedArrival;
  bool _showStopFields = false;

  @override
  void initState() {
    super.initState();
    _selectedDeparture = _stations.first;
    _selectedArrival = _stations[1];
  }

  void _onSearchPressed() {
    if (_busSearchController.text.trim().isNotEmpty) {
      setState(() {
        _showStopFields = true;
      });
    }
  }

  void _submitRoute() {
    if (_busSearchController.text.isNotEmpty &&
        _selectedDeparture != null &&
        _selectedArrival != null) {
      Navigator.pop(context, {
        'busNumber': '${_busSearchController.text}번',
        'departure': _selectedDeparture!,
        'arrival': _selectedArrival!,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾는 노선 추가'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('버스', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _busSearchController,
                    decoration: const InputDecoration(
                      hintText: '버스 번호를 입력하세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _onSearchPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('검색'),
                ),
              ],
            ),
            if (_showStopFields) ...[
              const SizedBox(height: 24),
              const Text('출발지', style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedDeparture,
                items: _stations
                    .map((station) => DropdownMenuItem(
                  value: station,
                  child: Text(station),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDeparture = value),
              ),
              const SizedBox(height: 24),
              const Text('도착지', style: TextStyle(fontSize: 16)),
              DropdownButtonFormField<String>(
                value: _selectedArrival,
                items: _stations
                    .map((station) => DropdownMenuItem(
                  value: station,
                  child: Text(station),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedArrival = value),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: _submitRoute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('완료'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
