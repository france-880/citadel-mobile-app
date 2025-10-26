import 'package:flutter/material.dart';
import 'qr_code_page.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final List<Map<String, String>> students = [
    {"name": "Villanueva, Margaret", "id": "20220001-C"},
    {"name": "Braza, Eula Marie", "id": "20220002-C"},
    {"name": "Duka, Jonn Michael", "id": "20220003-C"},
    {"name": "Edano, Crisanto", "id": "20220004-C"},
    {"name": "Dagohoy, Karl Andrew", "id": "20220005-C"},
    {"name": "Awas, Christy Jane", "id": "20220006-C"},
    {"name": "Torio, Mark Jay", "id": "20220007-C"},
    {"name": "Gacutan, Judy Mar", "id": "20220008-C"},
    {"name": "Recana, France", "id": "20220009-C"},
    {"name": "Cabanding, Hanniel Asher", "id": "20220010-C"},
    {"name": "Lacap, John Paul", "id": "20220011-C"},
    {"name": "Santos, Mary Grace", "id": "20220012-C"},
    {"name": "Reyes, Angelica", "id": "20220013-C"},
    {"name": "Lopez, Christian", "id": "20220014-C"},
    {"name": "Garcia, Miguel", "id": "20220015-C"},
    {"name": "Cruz, Anna", "id": "20220016-C"},
    {"name": "Flores, James", "id": "20220017-C"},
    {"name": "Ramirez, Sophia", "id": "20220018-C"},
    {"name": "Torres, David", "id": "20220019-C"},
    {"name": "Rivera, Isabella", "id": "20220020-C"},
  ];

  late List<bool> attendance;
  bool showAttendanceTab = false;

  @override
  void initState() {
    super.initState();
    attendance = List<bool>.filled(students.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final filteredStudents = showAttendanceTab
        ? students
            .asMap()
            .entries
            .where((e) => attendance[e.key])
            .map((e) => e.value)
            .toList()
        : students
            .asMap()
            .entries
            .where((e) => !attendance[e.key])
            .map((e) => e.value)
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 🔹 Custom AppBar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🔸 Back Button
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(77),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xFF000000),
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  // 🔸 Title Centered
                  const Text(
                    "Attendance",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sora",
                    ),
                  ),

                  // 🔸 QR Icon
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QRCodePage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(77),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.qr_code_scanner_rounded,
                          color: Color(0xFFEC5B05),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 🔹 Class Info Card (Fixed)
              Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Class Information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Sora',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "BSIT 2A",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Sora',
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Computer Programming",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Sora',
                            ),
                          ),
                        ],
                      ),
                          Text(
                        "7:00 - 10:00",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sora',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Segmented Toggle Header
              Container(
                height: 45,
                width: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => showAttendanceTab = false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: showAttendanceTab
                                ? Colors.transparent
                                : const Color(0xFFE9F5EA),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Students",
                            style: TextStyle(
                              color: showAttendanceTab
                                  ? Colors.black54
                                  : const Color(0xFF388E3C),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora",
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => showAttendanceTab = true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: showAttendanceTab
                                ? const Color(0xFFFFE4B3)
                                : Colors.transparent,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Attendance",
                            style: TextStyle(
                              color: showAttendanceTab
                                  ? const Color(0xFFE67E00)
                                  : Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Sora",
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Dynamic Scrollable List
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    itemCount: filteredStudents.length,
                    itemBuilder: (context, index) {
                      final student = filteredStudents[index];
                      final originalIndex = students.indexOf(student);
                      final isChecked = attendance[originalIndex];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFA1A1A1),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student["name"]!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Sora',
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  student["id"]!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Sora',
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  attendance[originalIndex] =
                                      !attendance[originalIndex];
                                });
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: isChecked
                                      ? const Color(0xFF81C784)
                                      : const Color(0xFFD9D9D9),
                                  border: Border.all(
                                    color: isChecked
                                        ? const Color(0xFF388E3C)
                                        : const Color(0xFFA1A1A1),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: isChecked
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
