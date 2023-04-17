import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/screen/auth/login_Screen.dart';
import 'package:gharbeti/validators/validators.dart';
import 'package:gharbeti/widget/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controller/signupController.dart';
import '../../widget/CustomButton.dart';
import '../../widget/CustomTextField.dart';
import '../../widget/Custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _controller = Get.put(SignUpController());
  TextEditingController? controller;
  // final TextEditingController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedVal = 'Kathmandu';
  var items = ['Kathmandu', 'Pokhara', 'Chitwan'];
  String? longitude;
  String? latitude;
  String? address;
  @override

  getPrefs() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    address = prefs.getString('address') ?? '';

    setState(() {
      longitude = (prefs.getDouble('longitude')?? '').toString() as String?;
      latitude = (prefs.getDouble('latitude')??'').toString() as String?;
      // _controller.houseController.text = '${longitude }${latitude}';
      print(_controller.houseController.text);
      _controller.cityController.text = _selectedVal;
      controller = new TextEditingController (text: address);
      // _controller.locationController.text = prefs.getString('address') ?? '';
    });
    print('called');
  }
  void initState() {
    getPrefs();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundcolor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _controller.formKey,
          child: Container(
            height: 900.h,
            child: Stack(
              children: [
                Container(
                    height: 450.0.h,
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset('assets/images/Rectangle 28.svg', fit: BoxFit.fill,)),
                Positioned.fill(
                  top: 50.0.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0).w,
                      child: Column(
                        children: [
                          CustomText(text: 'घरबेटी बा', fontWeight: FontWeight.w700, size: 40.0.sp, color: Colors.white, decoration: TextDecoration.underline,),

                          CustomText(text: 'घरभाडा अब नो चिन्ता', fontWeight: FontWeight.w400, size: 25.0.sp, color: Colors.white,),
                           SizedBox(height: 20.0.h),
                          CustomText(text: 'रेगीस्टर गर्नुहोस', fontWeight: FontWeight.w700, size: 25.0.sp, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 200.h,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0).w,
                      child: Container(
                        // margin: EdgeInsets.all(30.0),
                        height: 600.h,
                        width: MediaQuery.of(context).size.width*0.85,
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
                          padding: const EdgeInsets.symmetric(vertical: 15.0).h,
                          child: Column(
                            children: [
                              Text('Register', style: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: Colors.black, fontSize: 30.0.sp),),

                              CustomTextField(hint: 'Name', prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), controller:_controller.nameController, validator: Validator.checkFieldEmpty,),
                              // SizedBox(height: 5.0,),
                              CustomTextField(hint: 'Email', prefixIcon: Icon(Icons.email, color: AppColor.primarycolor,), controller: _controller.emailController, validator: Validator.checkEmailField,),
                              CustomTextField(hint: 'Phone Number', prefixIcon: Icon(Icons.phone, color: AppColor.primarycolor,),textInputType:TextInputType.phone, controller: _controller.phoneNoController, validator: Validator.checkPhoneField,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).w.h,
                                child: DropdownButtonFormField(
                                    value: _selectedVal,
                                    items: items.map((e) => DropdownMenuItem(child: Text(e, style: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w400, color: AppColor.primarycolor),), value: e)).toList(),
                                    onChanged: (val){
                                      setState(() {
                                        setState(() {
                                          _selectedVal = val as String;
                                          _controller.cityController.text = _selectedVal;
                                        });
                                      },
                                      );
                                    },
                                  icon: Icon(
                                    Icons.arrow_drop_down, color: AppColor.primarycolor,
                                  ),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(10.r, 0, 0, 0),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.0.w, color: AppColor.primarycolor
                                        ),
                                      ),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(6.0).w,
                                      ),
                                      prefixIcon: Container(
                                        margin: EdgeInsets.only(right: 16.0).r,
                                        decoration: BoxDecoration(
                                          border: Border(right: BorderSide(color: Color(0xFFD6D6D6), width: 2.0.w),
                                          ),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
                                            child: Icon(Icons.location_on, color: AppColor.primarycolor,)
                                        ),
                                      )
                                  ) ,
                                ),
                              ),
                              CustomTextField(hint: 'Address', prefixIcon: Icon(Icons.home_filled, color: AppColor.primarycolor,), controller: _controller.houseController, validator: Validator.checkFieldEmpty,),
                              SizedBox(height: 10.0.h,),
                              CustomButton(text: 'SUBMIT', onPressed: (){
                                _controller.createUser(context, name: _controller.nameController.text, phoneNumber: _controller.phoneNoController.text, city: _controller.cityController.text, email: _controller.emailController.text, mapLocation: '${longitude }${latitude}', address: _controller.houseController.text);
                                // _controller.submit();
                              }, height: 135.h, width: 35.w,)
                            ],
                          ),
                        ),

                      ),
                    ),
                ),
                Positioned.fill(
                    top: 800.h,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                          children: [
                            Text('Already have an account? ', style: GoogleFonts.poppins(fontSize: 20.0.sp, fontWeight: FontWeight.w400, color: Colors.black ),),
                            TextButton(onPressed: (){ Get.off(()=>LoginScreen());}, child: Text('LOGIN', style: GoogleFonts.poppins(fontSize: 18.0.sp, color: AppColor.primarycolor, fontWeight: FontWeight.w600),))
                          ]
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
