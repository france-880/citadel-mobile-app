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

  final weekDays = ["S", "M", "T", "W", "T", "F", "S"];
  final weekDayCodes = ["SU", "M", "TU", "W", "TH", "F", "SA"];

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
    selectedDay = getWeekDayCode(now);
  }

  String getWeekDayCode(DateTime date) {
    switch (DateFormat('E').format(date).toUpperCase()) {
      case "SUN":
        return "SU";
      case "MON":
        return "M";
      case "TUE":
        return "TU";
      case "WED":
        return "W";
      case "THU":
        return "TH";
      case "FRI":
        return "F";
      case "SAT":
        return "SA";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizes
    final circleSize = screenWidth * 0.11;
    final circleFontSize = circleSize * 0.4;
    final timeLabelWidth = screenWidth * 0.15;
    final timeFontSize = screenWidth * 0.035;
    final cardFontSize = screenWidth * 0.043;
    final codeFontSize = screenWidth * 0.035;
    final roomFontSize = screenWidth * 0.035;

    final day = DateFormat('d').format(now);
    final year = DateFormat('y').format(now);
    final month = DateFormat('MMMM').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 0.04, 16, screenWidth * 0.04, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Schedule",
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                "1st Semester",
                style: TextStyle(
                  fontSize: screenWidth * 0.038,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8C8C8C),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

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
                  SizedBox(width: screenWidth * 0.02),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        day,
                        style: TextStyle(
                          fontSize: screenWidth * 0.09,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Sora",
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            year,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sora",
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            month,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
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
              SizedBox(height: screenHeight * 0.025),

              // 🗓️ Weekday Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weekDays.length, (index) {
                  final displayLetter = weekDays[index];
                  final code = weekDayCodes[index];
                  final isSelected = code == selectedDay;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = code;
                      });
                    },
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.green[200] : Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          displayLetter,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Sora",
                            fontSize: circleFontSize,
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
              SizedBox(height: screenHeight * 0.025),

              // ⏰ Time + Schedule Cards
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.12),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    final sched = schedules[index];
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            width: timeLabelWidth,
                            child: buildTimeLabel(
                              sched["time"] as String,
                              fontSize: timeFontSize,
                            ),
                          ),
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: buildScheduleCard(
                              subject: sched["subject"] as String,
                              code: sched["code"] as String,
                              room: sched["room"] as String,
                              section: sched["section"] as String,
                              time: sched["time"] as String,
                              isActive: sched["isActive"] as bool,
                              cardFontSize: cardFontSize,
                              codeFontSize: codeFontSize,
                              roomFontSize: roomFontSize,
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

  Widget buildTimeLabel(String text, {required double fontSize}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
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
    required double cardFontSize,
    required double codeFontSize,
    required double roomFontSize,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isActive ? const Color.fromRGBO(200, 230, 201, 1) : const Color(0xFFF3F3F3),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: TextStyle(
                fontSize: cardFontSize,
                fontWeight: FontWeight.bold,
                fontFamily: "Sora",
                color: isActive ? Colors.green[900] : Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Text(
              code,
              style: TextStyle(
                fontSize: codeFontSize,
                fontFamily: "Sora",
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$room\n$section",
                  style: TextStyle(fontSize: roomFontSize, fontFamily: "Sora"),
                ),
                Text(
                  time,
                  style: TextStyle(fontSize: roomFontSize, fontFamily: "Sora"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
