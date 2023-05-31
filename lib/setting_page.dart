import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _nameAccount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? accessToken = '';
  bool isLoading = false;

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
    // var token = prefs.getString('accessToken');
    // setState(() {
    //   accessToken = token;
    // });
  }

  void _fetchUserInfo() async {
    var token = await getAccessToken();

    print(token);
    var url = Uri.parse("https://api.co-event.relipa.vn/api/user");
    setState(() {
      isLoading = true;
    });

    final res = await http.get(url);
    print(res);
  }

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   radius: 50,
              //   // backgroundImage: AssetImage('assets/avatar.png'),
              // ),
              // SizedBox(height: 20),
              Text(
                'User Name',
                style: TextStyle(fontSize: 24),
              ),
              TextFormField(
                  controller: _nameAccount,
                  decoration: const InputDecoration(
                    label: Text("Tên"),
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Xin hãy nhập tên';
                    }

                    return null;
                  }),
              TextFormField(
                  controller: _nameAccount,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Xin hãy nhập email';
                    }

                    return null;
                  }),
              TextFormField(
                  controller: _nameAccount,
                  decoration: const InputDecoration(
                    label: Text("Ngày sinh"),
                    icon: Icon(Icons.date_range),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Xin hãy nhập ngày sinh';
                    }
                    return null;
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
