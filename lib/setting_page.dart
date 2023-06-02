import 'package:demo_app/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final TextEditingController _nameAccount;
  late final TextEditingController _emailAccount;

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
      _nameAccount = TextEditingController(text: "Admin");
      _emailAccount= TextEditingController(text: "admin@admin.com");
    _fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://flutterx.com/thumbnails/artifact-2096.png"),
                // backgroundImage: AssetImage('assets/avatar.png'),
              ),
              SizedBox(height: 20),
              Text(
                'User Info',
                style: TextStyle(fontSize: 24),
              ),
              TextFormField(
                  controller: _nameAccount,
                  // initialValue: "Admin",
                  decoration: const InputDecoration(
                    label: Text("Tên"),
                    icon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }

                    return null;
                  }),
              TextFormField(
                  controller: _emailAccount,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }

                    return null;
                  }),
              // TextFormField(
              //     controller: _nameAccount,
              //     // initialValue: "01/01/1990",
              //     decoration: const InputDecoration(
              //       label: Text("Ngày sinh"),
              //       icon: Icon(Icons.date_range),
              //     ),
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'Xin hãy nhập ngày sinh';
              //       }
              //       return null;
              //     }),
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
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
