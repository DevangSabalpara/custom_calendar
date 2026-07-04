part of 'calendar_view.dart';

class CalendarState extends Equatable {
  final DateTime currentMonth;
  final DateTime? selectedDate;

  const CalendarState({
    required this.currentMonth,
    this.selectedDate,
  });

  CalendarState copyWith({
    DateTime? currentMonth,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [currentMonth, selectedDate];
}