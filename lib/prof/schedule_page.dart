import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final now = DateTime.now();
  late String selectedDay;
  final weekDays = ["S", "M", "T", "W", "TH", "F", "S"];

  final schedules = [
    {
      "time": "7:00 - 10:00",
      "subject": "Art Appreciation",
      "code": "GEC 006",
      "room": "301 - North",
      "section": "BSIT 2A",
      "isActive": true,
    },
    {
      "time": "10:00 - 1:00",
      "subject": "IT Major Elective 3",
      "code": "IT 113",
      "room": "302 - North",
      "section": "BSIT 4C",
      "isActive": false,
    },
    {
      "time": "1:00 - 4:00",
      "subject": "Quantitative Methods",
      "code": "IT 111",
      "room": "303 - North",
      "section": "BSIT 4C",
      "isActive": false,
    },
    {
      "time": "4:00 - 7:00",
      "subject": "System Integration and Architecture",
      "code": "IT 110",
      "room": "304 - North",
      "section": "BSIT 2B",
      "isActive": false,
    },
    {
      "time": "7:00 - 10:00",
      "subject": "Contemporary World",
      "code": "GEC 008",
      "room": "401 - North",
      "section": "BSIT 4C",
      "isActive": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = DateFormat('E').format(now).substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final day = DateFormat('d').format(now);
    final year = DateFormat('y').format(now);
    final month = DateFormat('MMMM').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Schedule",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "1st Semester",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8C8C8C),
                ),
              ),
              const SizedBox(height: 24),

              // 📅 Date Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/calendar_icon.png",
                    width: 38,
                    height: 38,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        day,
                        style: const TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora",
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            year,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sora",
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            month,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sora",
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🗓️ Weekday Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weekDays.length, (index) {
                  final letter = weekDays[index];
                  final isSelected = letter == selectedDay;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = letter;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.green[200]
                            : Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          letter,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sora",
                            color: isSelected
                                ? Colors.green[900]
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // ⏰ Time + Schedule Cards
              Expanded(
                child: ListView.builder(
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final sched = schedules[index];
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Time label
                          SizedBox(
                            width: 60,
                            child: buildTimeLabel(sched["time"] as String),
                          ),

                          // 🔹 Divider line (stretched per row → tuloy-tuloy look)
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            color: Colors.grey,
                          ),

                          // Schedule card
                          Expanded(
                            child: buildScheduleCard(
                              subject: sched["subject"] as String,
                              code: sched["code"] as String,
                              room: sched["room"] as String,
                              section: sched["section"] as String,
                              time: sched["time"] as String,
                              isActive: sched["isActive"] as bool,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          fontFamily: "Sora",
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget buildScheduleCard({
  required String subject,
  required String code,
  required String room,
  required String section,
  required String time,
  required bool isActive,
}) {
  return Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: isActive ? Colors.green[100] : const Color(0xFFF3F3F3),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: "Sora",
              color: isActive ? Colors.green[900] : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            code,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: "Sora",
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$room\n$section",
                style: const TextStyle(fontSize: 13, fontFamily: "Sora"),
              ),
              Text(
                time,
                style: const TextStyle(fontSize: 13, fontFamily: "Sora"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}