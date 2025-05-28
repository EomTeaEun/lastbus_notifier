import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController(text: '엄태은');
  final TextEditingController _addressController = TextEditingController(text: '대전광역시 동구 낭월동 거주');
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  final TextEditingController _guideController = TextEditingController();

  void _showEditDialog(String title, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title 입력'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: '$title을(를) 입력하세요'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('저장'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() => const Divider(
    height: 1,
    thickness: 1,
    color: Colors.black12, // 동일한 색상과 두께로 통일
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인정보'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey,
                child: Icon(Icons.tag_faces, color: Colors.white, size: 36),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: '이름',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    TextField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        hintText: '주소',
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          buildDivider(),
          ListTile(
            title: const Text('아이디'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('아이디', _idController),
          ),
          buildDivider(),
          ListTile(
            title: const Text('비밀번호 변경'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('비밀번호', _passwordController),
          ),
          buildDivider(),
          ListTile(
            title: const Text('이메일 변경'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('이메일', _emailController),
          ),
          buildDivider(),
          ListTile(
            title: const Text('이용 제한 내역'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('이용 제한 내역', _limitController),
          ),
          buildDivider(),
          ListTile(
            title: const Text('관심 키워드 설정'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('관심 키워드 설정', _keywordController),
          ),
          buildDivider(),
          ListTile(
            title: const Text('사용설명'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _showEditDialog('사용설명', _guideController),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}
