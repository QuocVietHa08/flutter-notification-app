import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_quill/extensions.dart';

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("submit -------------:");
    }
  }

  void _clearForm() {
    setState(() {
      _input1Controller.clear();
      _input2Controller.clear();
      _switchValue = false;
      _selectedDate = null;
      _selectedTime = null;
      _textEditorController = quill.QuillController.basic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo thông báo"),
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
                      label: Text("Tiêu đề"), icon: Icon(Icons.send)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Xin hãy nhập tiêu đề';
                    }

                    return null;
                  },
                ),
                FlutterMentions(
                  decoration: const InputDecoration(
                    label: Text("Người tham gia"),
                    icon: Icon(Icons.person),
                  ),
                  mentions: [
                    Mention(
                      trigger: '#',
                      data: [
                        {"id": "BO", "display": "BO"},
                        {"id": "HR", "display": "HR"},
                        {"id": "MKT", "display": "MKT"},
                        {"id": "R&D", "display": "R&D"},
                        {"id": "Relipa", "display": "Pelipa"},
                      ],
                      matchAll: true,
                    )
                  ],
                ),
                SwitchListTile(
                  title: const Text("Thông báo cho mọi người"),
                  value: _switchValue,
                  onChanged: checkboxCallback,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Thời gian '),
                  // ignore: unnecessary_null_comparison
                  subtitle: Text(_selectedDate != null && _selectedTime != null
                      ? '${dateValueFormat.format(_selectedDate ?? DateTime.now())} ${_selectedTime!.format(context)}'
                      : 'Không có ngày được chọn'),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((DateTime? date) {
                      if (date != null) {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((TimeOfDay? time) {
                          if (time != null) {
                            setState(() {
                              _selectedDate = date;
                              _selectedTime = time;
                            });
                          }
                        });
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Nội dung",
                  style: TextStyle(fontSize: 16),
                ),
                quill.QuillToolbar.basic(
                  controller: _textEditorController,
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
                      placeholder: "Nhập nội dung thông báo",
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
