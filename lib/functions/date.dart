import 'package:intl/intl.dart';

String formattedDate(timeStamp){
  var dateFromTimeStamp =
      DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
  return DateFormat('yyyy-MM-dd kk:mm:ss').format(dateFromTimeStamp);
}

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return duration.inHours !=  0 ? "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds" : duration.inMinutes != 0 ? "$twoDigitMinutes:$twoDigitSeconds" : twoDigitSeconds;
}
