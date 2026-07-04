import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calendar_cubit.dart';
part 'calendar_state.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});
  static const routeName = "/home";

  static Widget builder(BuildContext context) {
    // final args = ModalRoute.of(context)?.settings.arguments;
    return BlocProvider(
      create: (context) =>
          CalendarCubit(CalendarState(currentMonth: DateTime.now())),
      child: CalendarView(),
    );
  }

  final List<String> weekDays = const [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CalendarCubit, CalendarState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(context, state),
                _buildWeekDays(),
                Expanded(child: _buildCalendar(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CalendarState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              context.read<CalendarCubit>().previousMonth();
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Center(
              child: Text(
                "${monthName(state.currentMonth.month)} ${state.currentMonth.year}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CalendarCubit>().nextMonth();
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekDays() {
    return Row(
      children: weekDays.map((day) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                day,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCalendar(BuildContext context, CalendarState state) {
    final currentMonth = state.currentMonth;

    final daysInMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    ).day;

    final firstWeekday =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday % 7;

    final List<Widget> cells = [];

    // Empty cells
    for (int i = 0; i < firstWeekday; i++) {
      cells.add(const SizedBox());
    }

    // Month days
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);

      final isSelected =
          state.selectedDate != null &&
          state.selectedDate!.year == date.year &&
          state.selectedDate!.month == date.month &&
          state.selectedDate!.day == date.day;

      final today = DateTime.now();

      final isToday =
          today.year == date.year &&
          today.month == date.month &&
          today.day == date.day;

      cells.add(
        GestureDetector(
          onTap: () {
            context.read<CalendarCubit>().selectDate(date);
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? Colors.blue
                  : isToday
                  ? Colors.orange
                  : Colors.transparent,
            ),
            child: Center(
              child: Text(
                "$day",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: isSelected || isToday ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      children: cells,
    );
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
