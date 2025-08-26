import 'package:get/get.dart';
import 'package:intl/intl.dart';

String generateUniqueId() {
  int timestamp = DateTime.now().millisecondsSinceEpoch;
  return '$timestamp';
}

bool isToday(String dateStr) {
  // Define the date format
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

  // Parse the date string into a DateTime object
  DateTime inputDate = dateFormat.parse(dateStr);

  // Get today's date
  DateTime today = DateTime.now();

  // Compare the input date with today's date
  return inputDate.year == today.year &&
      inputDate.month == today.month &&
      inputDate.day == today.day;
}

String convertDate(String inputDate) {
  // Parse the input date string
  DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(inputDate);

  // Format the parsed date to the desired output format
  String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);

  return formattedDate;
}

String formatDate(String date) {
  List<String> parts = date.split('-');
  return '${parts[2]}-${parts[1]}-${parts[0]}';
}

bool currentMonth(String inputDate) {
  DateTime givenDate = DateTime.parse(formatDate(inputDate));

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Check if the month and year of the given date are the same as the current date
  bool isSameMonthAndYear = (givenDate.month == currentDate.month) &&
      (givenDate.year == currentDate.year);
  return isSameMonthAndYear;
}

bool hasDebt(List paidMonths) {
  var currentMonthPaid = false;
  var debtStatus = false;

  DateTime now = DateTime.now();
  bool isTodayGreaterThan10 = now.day >= 1;

  for (int j = 0; j < paidMonths.length; j++) {
    if (currentMonth(paidMonths[j]['paidDate'].toString()) == true) {
      currentMonthPaid = true;
      break;
    }
  }

  if (isTodayGreaterThan10) {
    if (currentMonthPaid) {
      debtStatus = false;
    } else {
      debtStatus = true;
    }
  }

  return debtStatus;
}

bool hasDebtFromPayment(List paidMonths) {
  var debtStatus = false;

  for (int j = 0; j < paidMonths.length; j++) {
    if (currentMonth(paidMonths[j]['paidDate'].toString()) == true &&
        paidMonths[j]['paymentCommentary'].toString().contains('chala')) {
      debtStatus = true;
      break;
    }
  }

  return debtStatus;
}


int calculateTotalFee(List payments) {
  int total = 0;

  for (int j = 0; j < payments.length; j++) {
     total += int.parse(payments[j]['paidSum']);
  }

  return total;
}




String checkStatus(List studyDays, String day) {
  String status = 'notChecked';
  int index = 0;
  // Parse the date string into a DateTime object

  bool isChecked = false;
  for (int i = 0; i < studyDays.length; i++) {
    if (studyDays[i]['studyDay'] == day.toString()) {
      isChecked = true;
      index = i;
      break;
    }
  }

  if (isChecked == false) {
    return status = "notChecked";
  } else {
    if (studyDays[index]['studyDay']  == day.toString() &&
        studyDays[index]['isAttended'] == true &&
        studyDays[index]['hasReason']['commentary'] == "" &&
        studyDays[index]['hasReason']['hasReason'] == false) {
      status = 'true';
    } else {
      status = 'false';
    }
  }
  return status;
}

String getGroupNameById(List list, String groupId) {
  print(list);
  var groupName = "";
  for (int i = 0; i < list.length; i++) {
    if (list[i]['group_i'
        'd'] == groupId) {
      groupName = list[i]['group_name'];
      break;
    }
  }
  print("NAME ${groupName}");
  return groupName;
}

bool hasReason(List studyDays, String day) {
  bool hasReason = false;
  for (int i = 0; i < studyDays.length; i++) {
    if (studyDays[i]['studyDay'] == day &&
        studyDays[i]['hasReason']['hasReason'] == true &&
        studyDays[i]['isAttended'] == false) {
      hasReason = true;
      break;
    }
  }
  return hasReason;
}

String getReason(List list,String day) {
  var result = "";
  var holat = false;
  var index = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i]['studyDay'] == day) {
      holat = true;
      index = i;
      break;
    }
  }

  if (holat) {
    result = list[index]['hasReason']['commentary'];
  }

  return result;
}

String formatNumber(num number) {
  NumberFormat formatter = NumberFormat.decimalPattern('en');
  String formattedNumber = formatter.format(number).replaceAll(',', ' ');
  return formattedNumber;
}

String convertDateToMonthYear(String d){
  // The input date string
  String inputDate = "$d";

  // Define the format of the input date string
  DateFormat inputFormat = DateFormat("dd-MM-yyyy");

  // Parse the input date string to a DateTime object
  DateTime date = inputFormat.parse(inputDate);

  // Define the desired output format
  DateFormat outputFormat = DateFormat("MMMM, yyyy");

  // Format the DateTime object to the desired output format
  String formattedDate = outputFormat.format(date);

  return formattedDate; // Output: August, 2024
}


List  calculateUnpaidMonths(List studyDays, List payments, ) {
  var studyMonths = [];
  var paidMonths = [];
  var shouldPay = [];


  studyDays = studyDays.where((item) => !item.endsWith('1')).toList();
  studyDays = studyDays.where((item) => !item.endsWith('0')).toList();
  studyDays = studyDays.where((item) => !item.endsWith('2025')).toList();


  for (int i = 0; i < studyDays.length; i++) {
    if (!studyMonths.contains(
      convertDateToMonthYear(studyDays[i].split('_')[1])
          .toString()
          .removeAllWhitespace +
          "#" +
          studyDays[i].split('_')[3],
    )) {
      studyMonths.add(
          convertDateToMonthYear(studyDays[i].split('_')[1])
              .toString()
              .removeAllWhitespace +
              "#" +
              studyDays[i].split('_')[3]
      );
    }
  }

  for (int i = 0; i < payments.length; i++) {
    if (!paidMonths.contains({
      convertDateToMonthYear(payments[i]['paidDate'])
          .toString()
          .removeAllWhitespace +
          "#" +
          payments[i]['subject']
    })) {
      paidMonths.add(convertDateToMonthYear(payments[i]['paidDate'])
          .toString()
          .removeAllWhitespace +
          "#" +
          payments[i]['subject']);
    }
  }


  for (int i = 0; i < studyMonths.length; i++) {
    if (!paidMonths.contains(studyMonths[i])) {
      shouldPay.add(studyMonths[i]);
    }
  }

  return shouldPay;
}
