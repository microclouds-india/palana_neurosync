import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palana_neurosync/Vars/Vars.dart';
import 'package:http/http.dart' as http;

import '../../../Database/Alam Database/alamyDatabase.dart';

class AlarmSetScreen extends StatefulWidget {
  @override
  _AlarmSetScreenState createState() => _AlarmSetScreenState();
}

class _AlarmSetScreenState extends State<AlarmSetScreen> {
  String _selectedDate = '';
  DateTime? sDate;
  TimeOfDay? sTime;
  String _selectedTime = '';
  String _reminderText = '';
  List<bool> switchBtn = [];
  List<Map<String, Object?>>? alamGetDatas;
  List<Map<String, dynamic>>? _alldata;
  bool _load = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('dd-MM-yyyy').format(picked);
        sDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
        sTime = picked;
      });
    }
  }

  getAlamLocalData() async {
    alamGetDatas = await alamyDatabase.rawQuery('SELECT * FROM alamyview');
    setState(() {
      _alldata = alamGetDatas;
      _load = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlamLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            addnewAlam();
          },
          child: Icon(
            Icons.alarm_add,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Set your alaram",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: _load
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _alldata!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              width: 80,
                              height: 80,
                              child: Center(
                                child: Text(
                                  _alldata![index]['time']??'No time',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _alldata![index]['reminder']??'No reminder',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Date: ${_alldata![index]['date']??'No date'}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Switch(
                              value: switchBtn[index],
                              activeColor: Colors.blue,
                              onChanged: (bool value) async {
                                // final prif = await SharedPreferences.getInstance();
                                setState(() {
                                  switchBtn[index] = value;
                                });

                                if (switchBtn[index] == true) {
                                  sPremiumNotify(
                                      sTime!.hour, sTime!.minute, sDate!, 0);
                                } else {
                                  AwesomeNotifications().cancel(0);
                                }
                                // var url = Uri.parse(
                                //     'https://cashbes.com/palana/apis/alam_settings');
                                // var rasponse = await http.post(url, body: {
                                //   'token': prif.getString('Token').toString(),
                                //   'alert_time': _selectedTime,
                                //   'alert_date': _selectedDate,
                                //   'message': _reminderText,
                                // });
                                // print(rasponse.statusCode);
                                // if (rasponse.statusCode == 200) {
                                //   ScaffoldMessenger(
                                //       child: SnackBar(
                                //           content: Text("Alaram added success fully!")));
                                //   print('Alaram succefully');
                                // } else {
                                //   ScaffoldMessenger(child: SnackBar(content: Text("Error!")));
                                // }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: Text('No Alarams!'),
              ));
  }

  addnewAlam() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: Container(
                width: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Set your alaram",
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 4.0,
                    ),
                    //body
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Date',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  _selectedDate.isEmpty
                                      ? 'Choose Date'
                                      : _selectedDate,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Select Time',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          InkWell(
                            onTap: () => _selectTime(context),
                            child: Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  _selectedTime.isEmpty
                                      ? 'Choose Time'
                                      : _selectedTime,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Reminder Text',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _reminderText = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter Reminder Text',
                                border: OutlineInputBorder(),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16)),
                          ),
                        ],
                      ),
                    ),
                    //body
                    GestureDetector(
                      onTap: () async {
                        if (_selectedTime.isEmpty &&
                            _reminderText.isEmpty &&
                            _selectedDate.isEmpty) {
                          ScaffoldMessenger(
                              child: SnackBar(
                                  content:
                                      Text("Please select time and date!")));
                        } else {
                          Navigator.of(context).pop();
                          addAlamyLocalDataBase(
                              _selectedTime, _reminderText, _selectedDate);
                          switchBtn.add(false);
                          ScaffoldMessenger(
                              child: SnackBar(
                                  content: Text('Alaram added successfully')));
                          getAlamLocalData();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: bColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Text(
                          "Set Alaram",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  sPremiumNotify(int houre, int minut, DateTime dateS, int id) async {
    print(id);
    var calendar = NotificationCalendar(
      day: dateS.day,
      month: dateS.month,
      year: dateS.year,
      hour: houre,
      minute: minut,
      allowWhileIdle: true,
      repeats: true,
    );

    // create a notification
    var notification = NotificationContent(
      id: id,
      channelKey: 'basic_channel',
      title: 'Scheduled Notification',
      body: 'This is a scheduled notification for day at hour:minute',
      notificationLayout: NotificationLayout.Default,
    );

    // schedule the notification
    AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        day: dateS.day,
        month: dateS.month,
        year: dateS.year,
        hour: houre,
        minute: minut,
        repeats: true,
      ),
      content: notification,
    );
  }
}
