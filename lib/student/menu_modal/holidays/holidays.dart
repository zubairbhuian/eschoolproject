
import 'package:eschoolproject/Widget/app_default_bar.dart';
import 'package:eschoolproject/Widget/app_indecator.dart';
import 'package:eschoolproject/student/data/network/apis/api_client.dart';
import 'package:eschoolproject/student/data/network/constants/endpoints.dart';
import 'package:eschoolproject/student/utils/constants.dart';
import 'package:flutter/material.dart';

class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({Key? key}) : super(key: key);

  @override
  State<HolidaysScreen> createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime firstDay = DateTime.utc(2010, 1, 1);
  DateTime lastDay = DateTime.utc(2100);
  DateTime?selectedDay;
  bool isLoading = false;

  dynamic holidayList;
 dynamic holidayData;


  @override
  void initState() {  // 
    super.initState();
   selectedDay = _focusedDay;
    getHolidays();

  }


  Future<dynamic>getHolidays ()async{
    isLoading =true;
    holidayList = await ApiClient().getData(Endpoints.holidayList);
    if(holidayList == false){
      isLoading = true;
    }else{
      holidayData=holidayList["data"];
      setState(() {
        isLoading = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        AppDefaultBar(title: "Holidays"),
        isLoading == true?
        const Expanded(child: Center(child: AppIndecator()))
            :
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     decoration: BoxDecoration(
        //         color: Colors.black12,
        //         borderRadius: BorderRadius.circular(16)),
        //     child: TableCalendar(
        //       focusedDay:_focusedDay,
        //       firstDay: firstDay,
        //       lastDay: lastDay,
        //       headerStyle: const HeaderStyle(
        //         formatButtonVisible: false,
        //         titleCentered: true,
        //       ),
        //
        //       onDaySelected: ((selectedDay, focusedDay) {
        //         if(!isSameDay(_selectedDay, selectedDay)){
        //           setState(() {
        //             _selectedDay=selectedDay;
        //             _focusedDay =focusedDay;
        //           });
        //
        //         }
        //       }),
        //       selectedDayPredicate: (day){
        //         return isSameDay(_selectedDay, day);
        //       },
        //     ),
        //   ),
        // ),

       Expanded(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child:ListView.builder(
               padding: EdgeInsets.zero,
               itemCount: holidayData?.length ?? 0,
               itemBuilder: (context,  index) {
                 return Card(
                     color: Constants.whiteGrey,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(
                             height: 5,
                           ),
                           Text(
                             holidayData[index]['description'].toString(),
                             style: const TextStyle(
                               color: Constants.primaryColor,
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                           Text(
                             holidayData[index]['date'].toString(),
                             style: const TextStyle(
                                 fontSize: 16,
                                 color: Colors.black,
                                 height: 1),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                         ],
                       ),
                     ));
               })

         ),
       )
      ],
    ),
    );
  }
}


/*ListView.builder(
               padding: EdgeInsets.zero,
               itemCount: _filterHolidayList(holidayList["data"], _focusedDay.month, _focusedDay.year).length,
               itemBuilder: (context,int index) {
                 var holidayData = _filterHolidayList(holidayList['data'], _focusedDay.month, _focusedDay.year);
                 return Card(
                     color: Colors.grey.shade300,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(
                             height: 5,
                           ),
                           Text(
                             //snapshot.data![index].title!.toString(),
                             holidayData[index]['description'].toString(),
                             style: const TextStyle(
                               color: Colors.black,
                               fontSize: 16,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                           Text(
                             holidayData[index]['date'].toString(),
                             // snapshot.data![index].date!.toString(),
                             style: const TextStyle(
                                 fontSize: 12,
                                 color: Colors.black,
                                 height: 1),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                         ],
                       ),
                     ));

               },)*/
/* List<Map<String, dynamic>> _filterHolidayList(
      List<Map<String, dynamic>> holidayData, int selectedMonth, int selectedYear)
  {
    return holidayData.where((holiday) {
      DateTime holidayDate = DateTime.parse(holiday['date'] as String);
      return holidayDate.month == selectedMonth && holidayDate.year == selectedYear;
    }).toList();
  }*/