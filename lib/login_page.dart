import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _submitForm() {
    // Perform your login logic here
    // You can access the entered values using _usernameController.text and _emailController.text
    // For simplicity, we'll assume the login is successful
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == 'admin@gmail.com' && password == 'abc@123') {
      // Show success message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success! Logged in'),
        ),
      );

      // navigate
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Show error message using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials'),
        ),
      );
    }
  }

  void _clearForm() {
    // Clear the input fields
    _passwordController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _loginInIdPlatform(BuildContext context) async {
    const String loginUrl = "https://api.co-event.relipa.vn/api/v1/auth/custom";

    var value = await launchUrl(
      Uri.parse(loginUrl),
      mode: LaunchMode.inAppWebView,
    );
    if (value) {
      await closeInAppWebView();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Page'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 0.0, left: 40.0, right: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: _clearForm,
                  child: const Text('Clear'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _loginInIdPlatform(context);
              },
              child: Text(
                'Login with Id account',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
