class DateFormatter {

  static String format(String date) {

    DateTime parsedDate = DateTime.parse(date);

    return
        "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
  }
}