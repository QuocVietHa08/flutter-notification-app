// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(begin: Alignment.topCenter, colors: <Color>[
//           Colors.orange[900],
//           Colors.orange[800],
//           Colors.orange[400]
//         ])),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 80,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'home_page.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _isPasswordVisible = false;

//   void _submitForm() {
//     // Perform your login logic here
//     // You can access the entered values using _usernameController.text and _emailController.text
//     // For simplicity, we'll assume the login is successful
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     if (email == 'admin@gmail.com' && password == 'abc@123') {
//       // Show success message using SnackBar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Success! Logged in'),
//         ),
//       );

//       // navigate
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     } else {
//       // Show error message using SnackBar
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Invalid credentials'),
//         ),
//       );
//     }
//   }

//   void _clearForm() {
//     // Clear the input fields
//     _passwordController.clear();
//     _emailController.clear();
//   }

//   @override
//   void dispose() {
//     // Clean up the controllers when the widget is disposed
//     _passwordController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }

//   void _loginInIdPlatform(BuildContext context) async {
//     const String loginUrl = "https://api.co-event.relipa.vn/api/v1/auth/custom";

//     var value = await launchUrl(
//       Uri.parse(loginUrl),
//       mode: LaunchMode.inAppWebView,
//     );
//     if (value) {
//       await closeInAppWebView();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Login Page'),
//       ),
//       body: Container(
//         padding: const EdgeInsets.only(top: 0.0, left: 40.0, right: 40.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TextField(
//               controller: _passwordController,
//               obscureText: !_isPasswordVisible,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 suffixIcon: IconButton(
//                   icon: Icon(_isPasswordVisible
//                       ? Icons.visibility_off
//                       : Icons.visibility),
//                   onPressed: _togglePasswordVisibility,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _submitForm,
//                   child: const Text('Submit'),
//                 ),
//                 const SizedBox(
//                   width: 30,
//                 ),
//                 ElevatedButton(
//                   onPressed: _clearForm,
//                   child: const Text('Clear'),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 _loginInIdPlatform(context);
//               },
//               child: Text(
//                 'Login with Id account',
//                 style: TextStyle(
//                     decoration: TextDecoration.underline, color: Colors.blue),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Login",
//                     style: TextStyle(color: Colors.white, fontSize: 40),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     "Welcome Back",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(60),
//                         topRight: Radius.circular(60))),
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(30),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 60,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromRGBO(225, 95, 27, .3),
//                                     blurRadius: 20,
//                                     offset: Offset(0, 10))
//                               ]),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey[200]))),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                       hintText: "Email or Phone number",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey[200]))),
//                                 child: TextField(
//                                   decoration: InputDecoration(
//                                       hintText: "Password",
//                                       hintStyle: TextStyle(color: Colors.grey),
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Text(
//                           "Forgot Password?",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         Container(
//                           height: 50,
//                           margin: EdgeInsets.symmetric(horizontal: 50),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Colors.orange[900]),
//                           child: Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         Text(
//                           "Continue with social media",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     color: Colors.blue),
//                                 child: Center(
//                                   child: Text(
//                                     "Facebook",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 30,
//                             ),
//                             Expanded(
//                               child: Container(
//                                 height: 50,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(50),
//                                     color: Colors.black),
//                                 child: Center(
//                                   child: Text(
//                                     "Github",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
