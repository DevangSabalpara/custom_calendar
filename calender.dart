import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime currentMonth = DateTime.now();
  DateTime? selectedDate;

  List<String> weekDays = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Calendar")),
      body: Column(
        children: [
          _buildHeader(),
          _buildWeekDays(),
          Expanded(
            child: _buildCalendar(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: previousMonth,
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Center(
              child: Text(
                "${monthName(currentMonth.month)} ${currentMonth.year}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: nextMonth,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    return Row(
      children: weekDays
          .map(
            (e) => Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                e,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  Widget _buildCalendar() {
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    int firstWeekday =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday % 7;

    List<Widget> cells = [];

    // Empty cells before the first day
    for (int i = 0; i < firstWeekday; i++) {
      cells.add(Container());
    }

    // Days
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date =
      DateTime(currentMonth.year, currentMonth.month, day);

      bool isSelected =
          selectedDate != null &&
              selectedDate!.year == date.year &&
              selectedDate!.month == date.month &&
              selectedDate!.day == date.day;

      bool isToday =
          DateTime.now().year == date.year &&
              DateTime.now().month == date.month &&
              DateTime.now().day == date.day;

      cells.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue
                  : isToday
                  ? Colors.orange
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$day",
                style: TextStyle(
                  color: isSelected || isToday
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: cells,
    );
  }

  void previousMonth() {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void nextMonth() {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  String monthName(int month) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return months[month];
  }
}