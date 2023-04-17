import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/screen/auth/EditProfile.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../widget/CustomTextField.dart';
import '../../widget/Custom_text.dart';
import '../../widget/color.dart';
import '../auth/EditGhar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}

class _ProfileScreenState extends State<ProfileScreen>{
  String name = "";
  String email = "";
  String address = "";
  String phoneNumber = "";
  String electricity = "";
  String water ="";
  String waste ="";
  String wifi = "";
  String otherServices ="";
  void getPrefs() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = SharedData.getUserName();
      email = SharedData.getEmail();
      address = SharedData.getUserCity();
      phoneNumber = SharedData.getPhoneNumber();
      electricity = SharedData.getElectricity();
      water = SharedData.getWater();
      waste = SharedData.getWaste();
      wifi = SharedData.getWifi();
      otherServices = SharedData.getOtherServices();
    });

  }
  @override
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.backgroundcolor,
        body: SingleChildScrollView(
          child:Column(
            children: [
              Container(
                height: 300.h,
                child: Stack(
                  children: [
                    Container(
                        height: 230.0.h,
                        width: 900.w,
                        child: SvgPicture.asset('assets/images/Rectangle 28.svg', fit: BoxFit.fill,)),
                    Positioned.fill(
                      top: 30.0.h,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text('Profile', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 24.0.sp),)
                      ),
                    ),
                    Positioned.fill(
                      top: 80.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0).w,
                        child: Container(
                          height: 250.h,
                          // margin: EdgeInsets.all(30.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0).w,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15.0,

                                  offset: Offset(
                                    0.0,
                                    0.75,
                                  ),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0).w,
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 50.0.r,
                                  backgroundColor: const Color(0xffF2F2F2),
                                  child: Icon(Icons.person, color: Colors.black,)
                              ),
                              title: name == '' ? Container() :
                              Text(name, style: GoogleFonts.poppins(fontSize: 22.0.sp, fontWeight:FontWeight.w600 ),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  email == '' ? Container() :
                                  Text(email, style: GoogleFonts.poppins(fontSize:16.0.sp, fontWeight: FontWeight.w400 ),),
                                  address == '' ? Container():
                                  Text(address, style: GoogleFonts.poppins(fontSize:16.0.sp, fontWeight: FontWeight.w400 ),),
                                  phoneNumber == '' ? Container():
                                  Text(phoneNumber, style: GoogleFonts.poppins(fontSize:16.0.sp, fontWeight: FontWeight.w400 ),),
                                  CustomButton(text: 'Edit Profile', onPressed: (){
                                    Get.to(()=>EditProfileScreen());
                                  }, height: 50.h, width: 30.w,)
                                ],
                              ),
                            ),
                          ),

                        ),
                      ),
                    ),
                  ],

                ),
              ),
              SizedBox(height: 20.0.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0).w.h,
                    child: Text(
                      'Ghar Settings', style: GoogleFonts.poppins(fontSize: 22.0.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
                    child: Container(
                      height: 400.h,
                      width: MediaQuery.of(context).size.width*0.93,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0).h.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GharField(title: 'Electricity', image: 'assets/images/Vector1.svg', subtitle: '${electricity}',),
                            GharField(title: 'Water', image: 'assets/images/Vector2.svg', subtitle: '${water}', ),
                            GharField(title: 'Waste', image: 'assets/images/bag.svg', subtitle: '${waste}', ),
                            GharField(title: 'Wifi', image: 'assets/images/bag.svg', subtitle: '${wifi}',),
                            GharField(title: 'Other Services', image: 'assets/images/bag.svg', subtitle: '${otherServices}',),
                            CustomButton(text: 'Edit Ghar', height: 40.h, width: 30.w, onPressed: (){
                              Get.to(()=>EditGharscreen());
                            },)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0.h,),
              CustomButton(text: 'Log Out', height: 135.h, width: 35.w, onPressed: () async{
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('isLoggedIn');
                Get.off(()=>LoginScreen());
              },)
            ],
          ),
          ),
        ),
    );
  }


}

class GharField extends StatelessWidget {
   String? title;
   String? image;
   String subtitle;
   GharField({Key? key, this.image, this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(

          children: [

            Container(
              height: 50.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColor.backgroundcolor,

              ),
              child: Center(child: SvgPicture.asset(image!, height: 20.h,)),),
            SizedBox(width: 25.0.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!, style: GoogleFonts.poppins(fontSize: 18.0.sp, fontWeight: FontWeight.w400), ),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 18.0.sp, fontWeight: FontWeight.w400), ),
              ],
            )
          ],
        ),
        Icon(Icons.arrow_forward_ios_rounded, size: 20.0,)
      ],
    );
  }
}

