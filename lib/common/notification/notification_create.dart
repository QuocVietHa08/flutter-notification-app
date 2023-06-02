import 'package:demo_app/home_page.dart';
import 'package:demo_app/notification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:page_transition/page_transition.dart';

class NotificationCreate extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _NotificationCreateState createState() => _NotificationCreateState();
}

class _NotificationCreateState extends State<NotificationCreate> {
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  late bool _switchValue = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  var dateValueFormat = DateFormat('yyyy/MM/dd');
  quill.QuillController _textEditorController = quill.QuillController.basic();

  final _formKey = GlobalKey<FormState>();
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  String _mentionsGroup = '';

  @override
  void dispose() {
    _input1Controller.dispose();
    _input2Controller.dispose();
    _textEditorController.dispose();
    super.dispose();
  }

  void checkboxCallback(bool? checkboxState) {
    setState(() {
      _switchValue = checkboxState ?? true;
    });
  }

  void handleSetSelectedDate(DateTime value) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((TimeOfDay? time) {
      if (time != null) {
        setState(() {
          _selectedDate = value;
          _selectedTime = time;
        });
      }
    });
  }

  void _submitForm() async {
    var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/notification");

    var headers = {
      'Content-Type': 'application/json',
    };

    var submitData = {
      'title': _input1Controller.text,
      'content': _textEditorController.document.toPlainText(),
      'tags': _mentionsGroup,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'status_id': 1,
      'address': 'checking',
      'isImportant': _switchValue,
      'time': _selectedTime!.format(context),
    };

    var jsonBody = json.encode(submitData);

    final res = await http.post(url, headers: headers, body: jsonBody);
    if (res.statusCode == 201) {
      var resData = res.body;
      _clearForm();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage()),
      );
    } else {}
  }

  void _handleMentionAdd(value) {
    if (_mentionsGroup.isNotEmpty) {
      setState(() {
        _mentionsGroup = '${_mentionsGroup + value['id']},';
      });
    } else {
      setState(() {
        _mentionsGroup = '${value['id']},';
      });
    }
  }

  void _clearForm() {
    setState(() {
      _input1Controller.clear();
      _input2Controller.clear();
      _switchValue = false;
      _selectedDate = null;
      _selectedTime = null;
      _mentionsGroup = '';
      _textEditorController = quill.QuillController.basic();
    });
    // Navigator.push(context, PageTransition(child: NotificationPage(), type: PageTransitionType.leftToRight, isIos: true, duration: Duration(milliseconds: 400)));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _input1Controller,
                  decoration: const InputDecoration(
                      label: Text("Title"), icon: Icon(Icons.send)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }

                    return null;
                  },
                ),
                FlutterMentions(
                  onMentionAdd: (p0) {
                    _handleMentionAdd(p0);
                  },
                  decoration: const InputDecoration(
                    label: Text("Tags"),
                    icon: Icon(Icons.person),
                  ),
                  mentions: [
                    Mention(
                      trigger: '@',
                      data: [
                        {"id": "BO", "display": "BO"},
                        {"id": "HR", "display": "HR"},
                        {"id": "MKT", "display": "MKT"},
                        {"id": "R&D", "display": "R&D"},
                        {"id": "Relipa", "display": "Relipa"},
                      ],
                      matchAll: true,
                    )
                  ],
                ),
                SwitchListTile(
                  title: const Text("Important"),
                  value: _switchValue,
                  onChanged: checkboxCallback,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Time'),
                  // ignore: unnecessary_null_comparison
                  subtitle: Text(_selectedDate != null && _selectedTime != null
                      ? '${dateValueFormat.format(_selectedDate ?? DateTime.now())} ${_selectedTime!.format(context)}'
                      : 'No day choose'),
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                              height: 250,
                              color: Color.fromARGB(255, 255, 255, 255),
                              child: Column(
                                children: [
                                  Container(
                                    height: 180,
                                    child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.dateAndTime,
                                        initialDateTime: DateTime.now(),
                                        onDateTimeChanged: (DateTime val) {
                                          print((val));
                                          setState(() {
                                            _selectedDate = DateTime(
                                                val.year, val.month, val.day);

                                            _selectedTime = TimeOfDay(
                                                hour: val.hour,
                                                minute: val.minute);
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ));
                    // showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(2000),
                    //   lastDate: DateTime(2100),
                    // ).then((DateTime? date) {
                    //   if (date != null) {
                    //     showTimePicker(
                    //       context: context,
                    //       initialTime: TimeOfDay.now(),
                    //     ).then((TimeOfDay? time) {
                    //       if (time != null) {
                    //         setState(() {
                    //           _selectedDate = date;
                    //           _selectedTime = time;
                    //         });
                    //       }
                    //     });
                    //   }
                    // });
                  },
                ),
                // CupertinoDatePicker(
                //   initialDateTime: DateTime.now(),
                //   onDateTimeChanged: (val) {
                //     print(object)
                //   }),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Content",
                  style: TextStyle(fontSize: 16),
                ),
                quill.QuillToolbar.basic(
                  controller: _textEditorController,
                  toolbarIconSize: 20,
                  multiRowsDisplay: false,
                ),
                Expanded(
                  child: Container(
                    child: quill.QuillEditor(
                      controller: _textEditorController,
                      scrollable: true,
                      autoFocus: false,
                      readOnly: false,
                      expands: true,
                      padding: EdgeInsets.zero,
                      focusNode: FocusNode(),
                      scrollController: ScrollController(),
                      placeholder: "Enter notification content",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Tạo'),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                          onPressed: _clearForm, child: const Text("Clear"))
                    ],
                  ),
                )
              ],
            )),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
