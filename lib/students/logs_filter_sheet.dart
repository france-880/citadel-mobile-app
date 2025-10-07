import 'package:flutter/material.dart';

class LogsFilterSheet extends StatelessWidget {
  const LogsFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date pickers row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("From Date", style: TextStyle(fontSize: 16)),
              Icon(Icons.calendar_today),
              Text("To Date", style: TextStyle(fontSize: 16)),
              Icon(Icons.calendar_today),
            ],
          ),
          const SizedBox(height: 20),

          // Category filter
          const Text("Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            isExpanded: true,
            value: null,
            hint: const Text("Select category"),
            items: ["Class", "Attendance", "Time In", "Time Out"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {},
          ),

          const SizedBox(height: 20),

          // Search button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF064F32),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Search",
                  style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
