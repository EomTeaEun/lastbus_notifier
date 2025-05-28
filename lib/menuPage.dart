import 'package:flutter/material.dart';
import 'FavoriteRoutesPage.dart'; // 즐겨찾는 노선 페이지 import
import 'contact_manage_page.dart';
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('메뉴'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoriteRoutesPage()),
                  );
                },
                child: const Text(
                  '즐겨찾는 노선',
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // 알림 연락처 관리 페이지로 이동하려면 여기에 Navigator.push 추가
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactManagePage()),
    );
                },
                child: const Text(
                  '알림 연락처 관리',
                  style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}