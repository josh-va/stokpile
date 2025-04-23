import 'package:stokpile/services/entries/entry.dart';

extension MonthYearBreakpoint on List<Entry> {
  List<dynamic> withMonthYearBreakpoints() {
    List<dynamic> listWithBreakpoints = [];
    String currentMonthYear = '';

    for (var entry in this) {
      final String entryMonthYear = entry.monthYearString;

      if (entryMonthYear != currentMonthYear) {
        currentMonthYear = entryMonthYear;
        listWithBreakpoints.add(currentMonthYear);
      }
      listWithBreakpoints.add(entry);
    }
    return listWithBreakpoints;
  }
}
