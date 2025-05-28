import 'package:flutter/material.dart';
import 'AddFavoriteRoute.dart';

class FavoriteRoutesPage extends StatefulWidget {
  const FavoriteRoutesPage({super.key});

  @override
  State<FavoriteRoutesPage> createState() => _FavoriteRoutesPageState();
}

class _FavoriteRoutesPageState extends State<FavoriteRoutesPage> {
  final List<Map<String, String>> _favorites = [
    {
      'busNumber': '704번',
      'departure': '테크노밸리 5단지',
      'arrival': '충남대학교 정문',
    },
    {
      'busNumber': '704번',
      'departure': '충남대학교 정문',
      'arrival': '테크노밸리 5단지',
    },
    {
      'busNumber': '301번',
      'departure': '갤러리아 백화점',
      'arrival': '테크노밸리 2단지',
    },
  ];

  void _addFavoriteRoute() async {
    final newRoute = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(builder: (context) => const AddFavoriteRoute()),
    );

    if (newRoute != null) {
      setState(() {
        _favorites.add(newRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾는 노선'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addFavoriteRoute,
        backgroundColor: Colors.lightBlue.shade100,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemCount: _favorites.length,
          itemBuilder: (context, index) {
            final item = _favorites[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/bus.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 8),
                  Text(item['busNumber']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('승차: ${item['departure']}'),
                  Text('하차: ${item['arrival']}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}