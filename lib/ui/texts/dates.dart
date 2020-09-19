String displayDate(DateTime date) {
  return date.day.toString().padLeft(2, '0') +
      "/" +
      date.month.toString().padLeft(2, '0') +
      "/" +
      date.year.toString() +
      " " +
      date.hour.toString().padLeft(2, '0') +
      ":" +
      date.minute.toString().padLeft(2, '0') +
      ":" +
      date.second.toString().padLeft(2, '0');
}
