part of 'calendar_view.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit(super.initialState);

  void nextMonth() {
    emit(
      state.copyWith(
        currentMonth: DateTime(
          state.currentMonth.year,
          state.currentMonth.month + 1,
        ),
      ),
    );
  }

  void previousMonth() {
    emit(
      state.copyWith(
        currentMonth: DateTime(
          state.currentMonth.year,
          state.currentMonth.month - 1,
        ),
      ),
    );
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }
}
