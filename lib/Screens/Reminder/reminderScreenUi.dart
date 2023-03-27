import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Vars/Vars.dart';

class ReminderScreen extends StatefulWidget {
  // List selectedWeek;
  // ReminderScreen({required this.selectedWeek});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

List week = [
  "SUNDAY",
  "MONDAY",
  "TUESDAY",
  "WEDNESDAY",
  "THURSDAY",
  "FRIDAY",
  "SATURDAY",
];

List<String> selectedWeek = [];

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    double widthScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: screenColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Your Alaram',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(colors: [
                        Color(0xffff02d4),
                        // Color(0xff350387),
                        Color(0xff350387)
                      ])),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  setState(() {
                                    timeOfDay = value!;
                                  });
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  timeOfDay.format(context).toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                          Switch(
                            activeTrackColor: Colors.grey,
                            activeColor: Colors.white,
                            value: alaramOn,
                            onChanged: (value) {
                              setState(() {
                                alaramOn = value;
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: week.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onTap: () async {
                            final prif = await SharedPreferences.getInstance();
                            setState(() {
                              if (selectedWeek.contains(week[index])) {
                                selectedWeek.remove(week[index]);
                              } else {
                                selectedWeek.add(week[index]);
                              }
                              print(selectedWeek);
                              prif.setStringList('stringList', selectedWeek);
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: selectedWeek.contains(week[index])
                                  ? Colors.pink
                                  : Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                week[index][0],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Message",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w900),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    cursorColor: Color(0xff6600ff),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ))
              ],
            ),
            Visibility(
              visible: alaramOn,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        scheduleSelectedWeekdaysNotification(
                            timeOfDay.hour, timeOfDay.minute);
                      },
                      child: Container(
                        height: 50,
                        width: widthScreenWidth,
                        decoration: BoxDecoration(
                          color: Color(0xff23015b),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> scheduleSelectedWeekdaysNotification(
      int hour, int minute) async {
    // Schedule notifications for selected weekdays
    for (String day in selectedWeek) {
      // Calculate the time of the next notification
      DateTime scheduledTime = DateTime.now();
      int daysUntilNextNotification =
          week.indexOf(day.toUpperCase()) - scheduledTime.weekday;
      if (daysUntilNextNotification <= 0) {
        daysUntilNextNotification += 7;
      }
      scheduledTime = scheduledTime.add(Duration(
          days: daysUntilNextNotification, hours: hour, minutes: minute));

      // Create the notification
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: 'scheduled',
          title: 'Reminder',
          body: 'This is a reminder for ${day.toLowerCase()}',
        ),
        schedule: NotificationCalendar(
          weekday: scheduledTime.day,
          hour: scheduledTime.hour,
          minute: scheduledTime.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
        ),
      );
    }
  }
}
