import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:time_range_picker/time_range_picker.dart';

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
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));

  var dateValueFormat = DateFormat('yyyy/MM/dd');
  quill.QuillController _textEditorController = quill.QuillController.basic();
  final _formKey = GlobalKey<FormState>();
  bool _isAllDayEvent = true;

  @override
  void dispose() {
    _input1Controller.dispose();
    _input2Controller.dispose();
    _textEditorController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {}
  }

  void _clearForm() {
    setState(() {
      _input1Controller.clear();
      _input2Controller.clear();
      _selectedDate = null;
      _startTime = TimeOfDay.now();
      _endTime =
          TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 3)));
      _textEditorController = quill.QuillController.basic();
    });
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
                  decoration: const InputDecoration(
                    label: Text("Người tham gia"),
                    icon: Icon(Icons.person),
                  ),
                  mentions: [
                    Mention(
                      trigger: '#',
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
                  decoration: const InputDecoration(
                    label: Text("Nhóm người tham gia"),
                    icon: Icon(Icons.group),
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
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Ngày tổ chức sự kiện'),
                  // ignore: unnecessary_null_comparison
                  subtitle: Text(_selectedDate != null
                      ? '${dateValueFormat.format(_selectedDate ?? DateTime.now())} '
                      : 'Không có ngày được chọn'),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((DateTime? date) {
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }
                    });
                  },
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Thời gian sự kiện",
                        style: TextStyle(fontSize: 16)),
                    Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              showTimeRangePicker(
                                  context: context,
                                  start: const TimeOfDay(hour: 22, minute: 9));
                            },
                            child: const Text("Chọn")),
                            const SizedBox(width: 50,),
                        Switch(
                            value: _isAllDayEvent,
                            onChanged: (bool value) {
                              setState(() {
                                _isAllDayEvent = value;
                              });
                            }),
                            const SizedBox(width: 10,),
                            const Text("Cả ngày"),

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
                quill.QuillToolbar.basic(controller: _textEditorController,),
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
                const SizedBox(width: 50,),
                ElevatedButton(onPressed: _clearForm, child: const Text("Clear")),

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
