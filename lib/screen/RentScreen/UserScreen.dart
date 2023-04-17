import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/controller/FreeRoomController.dart';
import 'package:gharbeti/controller/billController.dart';
import 'package:gharbeti/controller/roomController.dart';
import 'package:gharbeti/model/HomeModel.dart';
import 'package:gharbeti/screen/RentScreen/BillScreen.dart';
import 'package:gharbeti/services/remote_Service.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gharbeti/model/HomeModel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/ApiConfig.dart';
import '../../model/BillModeL.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  final String name;
  const UserScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final controller = Get.put(BillController());
  final _controller = Get.put(RoomController());
  final c = Get.put(FreeRoomController());

  // List<BillModeL>? billLists;
  // var isLoaded = false;

  // getData() async {
  //   billLists = await RemoteService().getBills();
  //   if(billLists != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    c.getUserBillDetails();
    // controller.getData();
    final englishDate = DateTime.now();
    // controller.getBill();
    // print('nepali date');
    // print(nepaliDate);
    // controller.getData();
    // controller.apicall();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    NepaliDateTime currentTime = NepaliDateTime.now();
    final formatter = NepaliDateFormat('y').format(currentTime);
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: CustomAppBar(
        title: '${widget.name}',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
              child: Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0).h,
                  child: ListTile(
                      leading: CircleAvatar(
                          radius: 40.0.r,
                          backgroundColor: const Color(0xffF2F2F2),
                          child: Icon(Icons.person, color: Colors.black,)
                      ),
                      title: Text('${widget.name}', style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight:FontWeight.w600 ),),
                      subtitle:
                        Obx(()=>
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_controller.mapResponse.value['address'].toString(), style: GoogleFonts.poppins(fontSize:14.0.sp, fontWeight: FontWeight.w300 ),),
                              Text(_controller.mapResponse.value['phone_number'].toString(), style: GoogleFonts.poppins(fontSize:14.0.sp, fontWeight: FontWeight.w300 ),),
                              SizedBox(height: 5.0.h,),
                              Container(
                                height: 30.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset('assets/images/Group 41.svg',height: 20.0,),
                                    Text('Verified', style: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w300),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0).w.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bills', style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight: FontWeight.w600),),
                  Text('${formatter}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20.0.sp),)
                ],
              ),
            ),
            Container(
              child:

             // controller.load.value ? Center(child: CircularProgressIndicator(),):
                FutureBuilder<List<BillModeL>>(
                  future: c.getUserBillDetails(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return  ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          // itemCount: controller.billLists.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            var bills = snapshot.data![index];

                            // var date = bills.englishBillCreateDate;
                            var nepalidate = bills.nepaliBillCreateDate;
                            // DateFormat format = DateFormat('yyyy-M-d');
                            // DateTime date = format.parse(nepalidate!);
                            // print(date);
                            DateTime dateTime = DateTime.parse(nepalidate!);
                            String formattedDate = DateFormat('MM/dd/yyyy').format(dateTime);
                            DateTime formattedNepaliDate = DateTime.parse(formattedDate);
                            final dateFormat = DateFormat("MM-dd-yyyy");
                            final date = dateFormat.parse(dateTime.toString());
                            print(date);
                            print(formattedNepaliDate);
                            // print(formattedDate);

                            // print(dateTime);
                            // print(dateTime);
                            // var bills = controller.billLists.value[index];
                            // var date = bills.englishBillCreateDate;
                            // DateTime dateTime = DateTime.parse(date!);
                           //  final nepaliDate = NepaliDateTime.fromDateTime(dateTime);
                           // final nepaliMonth = NepaliDateFormat.MMMM().format(NepaliDateTime(dateTime.year, dateTime.month, dateTime.weekday)).toString();
                           // print(nepaliMonth);
                           // print(nepaliMonth);
                            // var date = bills.englishBillCreateDate;
                            // var nepalidate = bills.nepaliBillCreateDate;
                            // NepaliDateTime nepaliDateTime = NepaliDateTime.fromDateTime(nepalidate);
                            // int nepaliMonth = nepaliDateTime.month;

                            // String nepaliMonth1 = NepaliDateFormat('MMMM').format(date);
                            // int month = date.month;
                            // String monthString = DateFormat('MMMM').format(date!);
                            // String monthString = DateTime(date.year, month).toString().split(' ')[0];
                            // print(monthString);
                            // String bill = details[index].paid;
                            // print(bill);
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0).w.h,
                              child: GestureDetector(
                                onTap: ()async{
                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var uid = bills.uuid.toString();
                                  prefs.setString('BillUid', uid);
                                  print('hello');
                                  print(prefs.getString('BillUid'));
                                  // print(controller.billModels);
                                  Get.to(()=>BillScreen(title: 'nepaliMonth', name:widget.name,));
                                },
                                child: Container(
                                  height: 110.h,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.0)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0).w.h,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('nepaliMonth', style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight: FontWeight.w600),),
                                            bills.paidStatus == false ? Text('Unpaid',style: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w700, color: Color(0xFFFF0000))) : Text('Paid',style: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w700, color:  Color(0xFF05FF00))
                                            ),],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0).w.h,
                                        child:
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Total: ${snapshot.data![index].totalCharge} ', style: GoogleFonts.poppins(fontSize: 12.0.sp, fontWeight: FontWeight.w300), ),
                                            Text('Due: ${snapshot.data![index].paidAmount}', style: GoogleFonts.poppins(fontSize: 12.0.sp, fontWeight: FontWeight.w300),),
                                            Text('Credit: ${snapshot.data![index].creditAmount}', style: GoogleFonts.poppins(fontSize: 12.0.sp, fontWeight: FontWeight.w300),)
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                  },

                ),
             ),
          ],
        ),
      ),
    );
  }
}
