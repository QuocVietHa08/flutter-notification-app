import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_app/event_page.dart';

class EventCreate extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  late String _startTime = '';
  late String _endTime = '';
  late bool _switchValue = false;
  TimeOfDay? _selectedTime;

  var dateValueFormat = DateFormat('yyyy/MM/dd');
  quill.QuillController _textEditorController = quill.QuillController.basic();
  final _formKey = GlobalKey<FormState>();
  bool _isAllDayEvent = false;

  String _mentionsGroup = '';
  String _mentionsPerson = '';

  void _clearForm() {
    setState(() {
      _input1Controller.clear();
      _input2Controller.clear();
      _selectedDate = null;
      _mentionsGroup = '';
      _mentionsPerson = '';
      // _startTime = TimeOfDay.now();
      // _endTime =
      //     TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));
      _startTime = '';
      _endTime = '';

      _textEditorController = quill.QuillController.basic();
    });
  }

  @override
  void dispose() {
    _input1Controller.dispose();
    _input2Controller.dispose();
    _textEditorController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    var url = Uri.parse("https://api.co-event.relipa.vn/api/v1/event");

    var headers = {
      'Content-Type': 'application/json',
    };
    // print(_startTime);

    // print(jsonEncode({
    //   'startTime': _startTime,
    //   'endTime': _endTime,
    // }));

    var submitData = {
      'title': _input1Controller.text,
      'content': _textEditorController.document.toPlainText(),
      'tags': _mentionsGroup,
      'date': DateFormat('yyyy-MM-dd').format(_selectedDate!),
      'status_id': 1,
      'address': 'checking',
      'isImportant': _switchValue,
      'time': jsonEncode({
        'startTime': _startTime,
        'endTime': _endTime,
      }),
      'attenders': _mentionsPerson,
    };

    var jsonBody = json.encode(submitData);
    print(submitData);

    final res = await http.post(url, headers: headers, body: jsonBody);
    print(res);
    if (res.statusCode == 201) {
      var resData = res.body;
      _clearForm();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventPage()),
      );
    }
  }

  void _handleMentionGroupAdd(value) {
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

  void _handleMentionPersonAdd(value) {
    if (_mentionsPerson.isNotEmpty) {
      setState(() {
        _mentionsPerson = '${_mentionsPerson + value['id']},';
      });
    } else {
      setState(() {
        _mentionsPerson = '${value['id']},';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text("Tạo sự kiện"),
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
                      return 'Please enter a value';
                    }

                    return null;
                  },
                ),
                FlutterMentions(
                  onMentionAdd: (p0) {
                    _handleMentionPersonAdd(p0);
                  },
                  decoration: const InputDecoration(
                    label: Text("Người tham gia"),
                    icon: Icon(Icons.person),
                  ),
                  mentions: [
                    Mention(
                      trigger: '@',
                      data: [
                        {"id": "HQV", "display": "Hà Quốc Việt"},
                        {"id": "MVG", "display": "Mai Văn Giáp"},
                        {"id": "VVV", "display": "Vũ Văn Vịnh"},
                      ],
                      matchAll: true,
                    )
                  ],
                ),
                FlutterMentions(
                  onMentionAdd: (p0) {
                    _handleMentionGroupAdd(p0);
                  },
                  decoration: const InputDecoration(
                    label: Text("Nhóm người tham gia"),
                    icon: Icon(Icons.group),
                  ),
                  mentions: [
                    Mention(
                      trigger: '@',
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
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Ngày tổ chức sự kiện'),
                  // ignore: unnecessary_null_comparison
                  subtitle: Text(_selectedDate != null
                      ? '${dateValueFormat.format(_selectedDate ?? DateTime.now())} '
                      : 'Không có ngày được chọn'),
                  onTap: () {
                    // showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(2000),
                    //   lastDate: DateTime(2100),
                    // ).then((DateTime? date) {
                    //   if (date != null) {
                    //     setState(() {
                    //       _selectedDate = date;
                    //     });
                    //   }
                    // });
                    showCupertinoModalPopup(
                        context: context,
                        builder: (_) => Container(
                              height: 250,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    height: 180,
                                    child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                        onDateTimeChanged: (DateTime val) {
                                          setState(() {
                                            _selectedDate = DateTime(
                                                val.year, val.month, val.day);
                                          });
                                        }),
                                  )
                                ],
                              ),
                            ));
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Thời gian sự kiện",
                        style: TextStyle(fontSize: 16)),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              final TimeRange pickedTimeRange =
                                  await showTimeRangePicker(
                                context: context,
                                onEndChange: (value) {
                                  setState(() {
                                    var convertTime = TimeOfDay(
                                            hour: value.hour,
                                            minute: value.minute)
                                        .format(context);
                                    setState(() {
                                      _endTime = convertTime;
                                    });
                                  });
                                },
                                onStartChange: (value) {
                                  setState(() {
                                    var convertTime = TimeOfDay(
                                            hour: value.hour,
                                            minute: value.minute)
                                        .format(context);
                                    setState(() {
                                      _startTime = convertTime;
                                    });
                                  });
                                },
                              );

                              // print(pickedTimeRange);
                              if (kDebugMode) {
                                print(pickedTimeRange.endTime);
                                var convertStartTime =
                                    pickedTimeRange.startTime.format(context);
                                var convertEndTime =
                                    pickedTimeRange.endTime.format(context);
                                setState(() {
                                  _startTime = convertStartTime;
                                  _endTime = convertEndTime;
                                });
                              }
                            },
                            child: const Text("Chọn")),
                        // const SizedBox(
                        //   width: 50,
                        // ),
                        Spacer(),
                        Switch(
                            value: _isAllDayEvent,
                            onChanged: (bool value) {
                              setState(() {
                                _isAllDayEvent = value;
                              });
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Cả ngày"),
                      ],
                    ),
                    // if (_endTime.isNotEmpty && _startTime.isNotEmpty )
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text('Thời gian bắt đầu: $_startTime',
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                        ),
                        Text('Thời gian kết thúc: $_endTime',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    )
                  ],
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                      label: Text("Địa điểm"), icon: Icon(Icons.location_city)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Hãy nhập địa điểm';
                    }
                    return null;
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
                      expands: false,
                      padding: EdgeInsets.zero,
                      focusNode: FocusNode(),
                      scrollController: ScrollController(),
                      placeholder: "Enter your text here",
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
                          onPressed: _clearForm, child: const Text("Clear")),
                    ],
                  ),
                )
              ],
            )),
      ),
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: CustomFooterBar(),
    );
  }
}
