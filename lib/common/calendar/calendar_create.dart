import 'package:intl/intl.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:demo_app/common/layout/CustomFooterBar.dart';

class CalendarCreate extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CalendarCreateState createState() => _CalendarCreateState();
}

class _CalendarCreateState extends State<CalendarCreate> {
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
      setState(() {
        _input1Controller.clear();
        _input2Controller.clear();
        _switchValue = false;
        _selectedDate = null;
        _selectedTime = null;
        _textEditorController = quill.QuillController.basic();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Calendar Create"),
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
                  decoration: const InputDecoration(label: Text("Title")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: _input2Controller,
                  decoration:
                      const InputDecoration(label: Text("Add required groups")),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    // textDirection: TextDirection.RTL,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Column(
                        children: [
                          Text("Example"),
                          Text(""),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Send to Relipa #Relipa"),
                            Text("Send to specific grou MKT #MHKT"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SwitchListTile(
                  title: const Text("Switch"),
                  value: _switchValue,
                  onChanged: checkboxCallback,
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                  title: const Text('Date Picker'),
                  // ignore: unnecessary_null_comparison
                  subtitle: Text(_selectedDate != null && _selectedTime != null
                      ? '${dateValueFormat.format(_selectedDate ?? DateTime.now())} ${_selectedTime!.format(context)}'
                      : 'No date selected'),
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
                  "Content",
                  style: TextStyle(fontSize: 16),
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
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                )
              ],
            )),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomFooterBar(),
    );
  }
}
