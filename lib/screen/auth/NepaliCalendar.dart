import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nepali_utils/nepali_utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_date_picker/nepali_date_picker.dart';

class NepaliCalendar extends StatefulWidget {
  const NepaliCalendar({Key? key}) : super(key: key);

  @override
  State<NepaliCalendar> createState() => _NepaliCalendarState();
}


class _NepaliCalendarState extends State<NepaliCalendar> {
  final NepaliCalendarController _nepaliCalendarController =
  NepaliCalendarController();
  @override
  Widget build(BuildContext context) {
    final NepaliDateTime first = NepaliDateTime(2075, 5);
    final NepaliDateTime last = NepaliDateTime(2080, 3);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Nepali Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CleanNepaliCalendar(
              headerDayBuilder: (_, index) {
                return Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0).h,
                      child: Text(
                        '$_',
                        style:
                        TextStyle(color: (index == 6) ? Colors.red : null),
                      ),
                    ));
              },

              // headerBuilder: (_,__,___,____,______)=>Text("header"),
              headerDayType: HeaderDayType.fullName,
              controller: _nepaliCalendarController,
              onHeaderLongPressed: (date) {
                print("header long pressed $date");
              },
              onHeaderTapped: (date) {
                print("header tapped $date");
              },
              calendarStyle: CalendarStyle(
                // weekEndTextColor : Colors.green,
                selectedColor: Colors.deepOrange,
                dayStyle: TextStyle(fontWeight: FontWeight.bold),
                todayStyle: TextStyle(
                  fontSize: 20.0.sp,
                ),
                todayColor: Colors.orange.shade400,
                // highlightSelected: true,
                renderDaysOfWeek: true,
                highlightToday: true,
              ),
              headerStyle: HeaderStyle(
                enableFadeTransition: false,
                centerHeaderTitle: false,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                    fontSize: 20.0.sp),
              ),
              initialDate: NepaliDateTime.now(),
              firstDate: first,
              lastDate: last,
              language: Language.nepali,

              onDaySelected: (day) {
                print(day.toString());
              },

              // display the english date along with nepali date.
              dateCellBuilder: cellBuilder,
            ),
          ],
        ),
      ),
    );
  }

  Widget cellBuilder(isToday, isSelected, isDisabled, nepaliDate, label, text,
      calendarStyle, isWeekend) {
    // print(isSelected);
    Decoration _buildCellDecoration() {
      if (isSelected && isToday) {
        return BoxDecoration(
          // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(5.w),
            color: Colors.blue,
            border: Border.all(color: calendarStyle.selectedColor));
      }
      if (isSelected) {
        return BoxDecoration(
          // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(5.w),
            border: Border.all(color: calendarStyle.selectedColor));
      } else if (isToday && calendarStyle.highlightToday) {
        return BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: Colors.transparent),
          color: Colors.blue,
        );
      } else {
        return BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: Colors.transparent),
        );
      }
    }

    return AnimatedContainer(
      padding: EdgeInsets.all(3.w),
      duration: Duration(milliseconds: 2000),
      decoration: _buildCellDecoration(),
      child: Center(
        child: Column(
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 20.sp, color: isWeekend ? Colors.red : null)),

            // to show events
            Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 1,
                )),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(nepaliDate.toDateTime().day.toString(),
                  style: TextStyle(
                      fontSize: 8.sp, color: isWeekend ? Colors.red : null)),
            ),
          ],
        ),
      ),
    );
  }
}
