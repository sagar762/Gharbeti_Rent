import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti/controller/roomController.dart';
import 'package:gharbeti/model/UserDetail.dart';
import 'package:gharbeti/screen/RentScreen/UserScreen.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gharbeti/model/HomeModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import '../../controller/FreeRoomController.dart';

class PendingRentScreen extends StatefulWidget {
  const PendingRentScreen({Key? key}) : super(key: key);

  @override
  State<PendingRentScreen> createState() => _PendingRentScreenState();
}

class _PendingRentScreenState extends State<PendingRentScreen> {
  final controller = Get.put(RoomController());
  final c = Get.put(FreeRoomController());

  @override
  void initState() {
    c.getUserDetail();
    // controller.getUserDetail();
    // TODO: implement initState
    super.initState();
  }
  // void dispose() {
  //   // Dispose of your reactive variables or controllers here
  //   controller.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    NepaliDateTime currentTime = NepaliDateTime.now();
    final formatter = NepaliDateFormat('y').format(currentTime);
    // final formattedDate = formatter.format(currentTime);
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      appBar: CustomAppBar(
        title: 'RENTS',
      ),
      body:
      // Obx(() =>
      // controller.loading.value == true? Center(child: CircularProgressIndicator(),) :
        FutureBuilder<List<UserDetail>>(
        future: c.getUserDetail(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0).w.h,
                    child: GestureDetector(
                      onTap: ()async{
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        var rentId = snapshot.data![index].id.toString();
                        prefs.setString('RentID', rentId);
                        Get.to(()=>UserScreen(name:snapshot.data![index].name.toString()));
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => rents[index].route));
                      },
                      child: Container(
                        height: 60.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0).w.h,
                          child: Text('${snapshot.data![index].name}', style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight: FontWeight.w600),),
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

        }

        ),

  // ),
    );
  }
}
