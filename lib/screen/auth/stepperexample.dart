// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gharbeti/screen/home/BottomNavigationBar.dart';
// import 'package:gharbeti/utils/sharedPreferences.dart';
// import 'package:gharbeti/validators/validators.dart';
// import 'package:gharbeti/widget/color.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../controller/steper_controller.dart';
// import '../../model/ApiConfig.dart';
// import '../../widget/CustomButton.dart';
// import '../../widget/CustomTextField.dart';
// import '../../widget/Custom_text.dart';
// import 'dart:io';
// import 'package:get/get.dart';
// import 'MapScreen.dart';
// import 'package:gharbeti/model/Class_ModeL.dart';
// import 'package:http/http.dart' as http;
//
// class StepperScreen extends StatefulWidget {
//   const StepperScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StepperScreen> createState() => _StepperScreenState();
// }
//
//
// class _StepperScreenState extends State<StepperScreen> {
//
//   void initState() {
//     getPrefs();
//     // getPrefs();
//     // TODO: implement initState
//     super.initState();
//   }
//   void CreateGharbeti(BuildContext context, {String? gharbetiName, String? user_name, String? houseNumber, String? numberOfRooms, String? userEmail, String? city, String? location, String? id, String? phoneNumber, String? address, String? imagePath}) async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final User = 'api/ghar';
//     id = prefs.getString('id');
//     user_name= SharedData.getUserName();
//     phoneNumber = SharedData.getPhoneNumber();
//     address = SharedData.getUserCity();
//     imagePath = prefs.getString('ImagePath')!;
//     userEmail = SharedData.getEmail();
//     print(id);
//     try{
//       var body = jsonEncode({'ghar_name': gharbetiName, 'ghar_number': houseNumber, 'user_email': userEmail, 'user_location':location, 'user_city': city, 'user_id':id, 'ghar_location':controller.addressController.text, 'user_name': user_name, 'user_phone':phoneNumber, 'user_address':address, 'bill_image':imagePath});
//       var response = await http.post(Uri.parse(ApiConfig.baseUrl+User),headers: {HttpHeaders.contentTypeHeader: "application/json"}, body: body);
//       if(response.statusCode==201 && formKeys[1].currentState!.validate()){
//         final id = extractidFromResponse(response.body).toString();
//         final uid = extractgharbetiuidFromResponse(response.body).toString();
//         prefs.setString('gharbhetiId', id).toString();
//         prefs.setString('gharbetiuid', uid).toString();
//         print(prefs.getString('gharbetiuid'));
//         print(prefs.getString('gharbhetiId'));
//         print(response.body);
//         Get.showSnackbar(
//           const GetSnackBar(
//             title: 'Success',
//             message: 'Ghar created Successfully',
//             backgroundColor: AppColor.primarycolor,
//             duration:  Duration(seconds: 3),
//           ),
//         );
//         setState(() {
//           _index += 1;
//         });
//
//       } else {
//         Get.showSnackbar(
//           GetSnackBar(
//             title: 'Failed',
//             message: '${response.body}',
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     } catch(e){
//       print(e);
//     }
//   }
//
//   static String extractidFromResponse(String responseBody) {
//     final decodedResponse = json.decode(responseBody);
//     return decodedResponse['gharbheti']['id'].toString();
//   }
//   static String extractgharbetiuidFromResponse(String responseBody) {
//     final decodedResponse = json.decode(responseBody);
//     return decodedResponse['gharbheti']['uuid'].toString();
//   }
//
//
//   void getPrefs()async{
//     // final SharedPreferences prefs = await SharedPreferences.getInstance();
//     controller.nameController.text = SharedData.getUserName();
//     controller.emailController.text = SharedData.getEmail();
//     controller.cityController.text = SharedData.getUserCity();
//   }
//
//
//
//
//   int _index = 0;
//   File? selectedImage;
//   String base64Image = "";
//
//   List<GlobalKey<FormState>> formKeys = [
//     GlobalKey<FormState>(),
//     GlobalKey<FormState>(),
//     GlobalKey<FormState>()
//   ];
//
//   final controller = Get.put(SteperController());
//
//
//
//   Future<void> chooseImage(type) async {
//     // ignore: prefer_typing_uninitialized_variables
//     var image;
//     if (type == "camera") {
//       image = await ImagePicker()
//           .pickImage(source: ImageSource.camera, imageQuality: 10);
//     } else {
//       image = await ImagePicker()
//           .pickImage(source: ImageSource.gallery, imageQuality: 25);
//     }
//     if (image != null)  {
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//       setState(() {
//         selectedImage = File(image.path);
//         // print(selectedImage);
//         base64Image = base64Encode(selectedImage!.readAsBytesSync());
//         prefs.setString('ImagePath', selectedImage.toString());
//         print(prefs.getString('ImagePath'));
//         // print(base64Image);
//         // prefs.setString('imagePath', selectedImage);
//         // won't have any error now
//       });
//     }
//     else {
//       return print('please select an image');
//     }
//   }
//
//   Future<void> _dialogBuilder(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Pick Image from!!'),
//           actions: <Widget>[
//             CustomButton(text: 'Camera', onPressed: (){
//               chooseImage("camera");
//               Get.back();
//             }, height: 135.h, width: 35.w,),
//             CustomButton(text: 'Gallery', onPressed: (){
//               chooseImage("gallery");
//               Get.back();
//             }, height: 135.h, width: 35.w,)
//           ],
//         );
//       },
//     );
//   }
//   String _selectedVal = 'Kathmandu';
//   var items = ['Kathmandu', 'Pokhara', 'Chitwan'];
//
//   void _cancelImage() {
//     setState(() {
//       selectedImage = null;
//     });
//   }
//
//   List<Step> steps() => [
//     Step(
//       state: _index > 0 ? StepState.complete : StepState.indexed ,
//         isActive: _index >= 0,
//         title: Text('Address Info',style: GoogleFonts.poppins(fontSize: 12.0.sp),),
//         content: Form(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           key: formKeys[0],
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomTextField(enabled:false, initialvalue: controller.addressController.text, hint: 'Address', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,), textInputType: TextInputType.text, validator: Validator.checkFieldEmpty,
//                 onChanged: (value) async {
//
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0).h,
//                 child: CustomButton(text: 'Choose from Map', onPressed: () async{
//                   final SharedPreferences prefs = await SharedPreferences.getInstance();
//                   // prefs.setString('number', controller.numberController.text);
//                   // print(prefs.getString('number'));
//                   Get.to(()=> MapScreen());
//                   setState(() {
//                     controller.getprefs();
//                   });
//                 }, height: 135.h, width: 35.w,),
//               ),
//               CustomTextField(
//                 hint: 'UserName', prefixIcon: Icon(Icons.person, color: AppColor.primarycolor, ), validator: Validator.checkFieldEmpty, controller: controller.nameController,
//               ),
//               CustomTextField(
//                 hint: 'Email', prefixIcon: Icon(Icons.email, color: AppColor.primarycolor,), validator: Validator.checkEmailField, controller: controller.emailController,
//               )
//             ],
//           ),
//         ),
//     ),
//     Step(
//         state: _index > 1 ? StepState.complete : StepState.indexed ,
//       isActive: _index >= 1,
//         title: Text('House Info',style: GoogleFonts.poppins(fontSize: 12.0.sp),),
//         content: Form(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           key: formKeys[1],
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: CustomText(text: 'कृप्या घर को विवरण भर्नुहोस ', fontWeight: FontWeight.w700, size: 32.0.sp, color: Colors.black, )),
//               SizedBox(height: 40.0.h,),
//               CustomTextField(controller:controller.gharbetiName, hint: 'Name', prefixIcon: SvgPicture.asset('assets/images/Vector4.svg'), validator: Validator.checkFieldEmpty,),
//               CustomTextField(controller:controller.houseNumberController, hint: 'House NUmber', prefixIcon: SvgPicture.asset('assets/images/Vector4.svg'),validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               // CustomTextField(hint: 'UserEmail',prefixIcon: Icon(Icons.email, color: AppColor.primarycolor, ), validator: Validator.checkEmailField,controller: controller.gharbetiEmailController,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0).w.h,
//                 child: DropdownButtonFormField(
//                   value: _selectedVal,
//                   items: items.map((e) => DropdownMenuItem(child: Text(e, style: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w400, color: AppColor.primarycolor),), value: e)).toList(),
//                   onChanged: (val){
//                     setState(() {
//                       setState(() {
//                         _selectedVal = val as String;
//                         controller.cityController.text = _selectedVal;
//                       });
//                     },
//                     );
//                   },
//                   icon: Icon(
//                     Icons.arrow_drop_down, color: AppColor.primarycolor,
//                   ),
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.fromLTRB(10.r, 0, 0, 0),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(width: 1.0.w, color: AppColor.primarycolor
//                         ),
//                       ),
//                       filled: true,
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide.none,
//                         borderRadius: BorderRadius.circular(6.0).w,
//                       ),
//                       prefixIcon: Container(
//                         margin: EdgeInsets.only(right: 16.0).r,
//                         decoration: BoxDecoration(
//                           border: Border(right: BorderSide(color: Color(0xFFD6D6D6), width: 2.0.w),
//                           ),
//                         ),
//                         child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
//                             child: Icon(Icons.location_on, color: AppColor.primarycolor,)
//                         ),
//                       )
//                   ) ,
//                 ),
//               ),
//               // CustomTextField(hint: 'City', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,), validator: Validator.checkFieldEmpty, controller: controller.cityController,),
//               CustomTextField(hint: 'Address', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,),validator: Validator.checkFieldEmpty, controller: controller.addressController1,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18.0).w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('House Bill', style: GoogleFonts.poppins(fontSize: 20.0.sp, color: AppColor.primarycolor, fontWeight: FontWeight.w500),),
//                     SizedBox(height: 10.0.h,),
//                     Stack(
//                       children: [
//                         Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12.0),
//                             ),
//                             child: selectedImage != null
//                                 ? Stack(
//                               children: [
//                                 Image.file(
//                                   selectedImage!,
//                                   fit: BoxFit.cover,
//                                   height: 150.h,
//                                   width: 150.w,
//
//                                 ),
//                                 Positioned.fill(
//                                   top: 8.h,
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child : Container(
//                                       child: InkWell(
//                                           onTap: (){
//                                             _cancelImage();
//                                           },
//                                           child: Center(child: Icon(Icons.cancel, color: Colors.red, size: 50,))),
//                                     ),
//                                   )
//                                 )
//                               ],
//
//                                 ) :
//                                 Container(
//                                   height: 150.h,
//                                   width: 150.w,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.backgroundcolor,
//                                       borderRadius: BorderRadius.circular(12.0)
//                                   ),
//                                   child: GestureDetector(
//                                       onTap: (){
//                                         _dialogBuilder(context);
//                                       },
//                                       child: Icon(Icons.add, size: 50.sp, color: AppColor.primarycolor,)),
//                                 ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//     ),
//     Step(
//         state: _index > 2 ? StepState.complete : StepState.indexed ,
//       isActive: _index>= 2,
//         title: Text('House Settings', style: GoogleFonts.poppins(fontSize: 12.0.sp),) ,
//         content: Form(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           key: formKeys[2],
//           child: Column(
//             children: [
//               CustomText(text: 'कृपया व्यक्तिगत विवरण भर्नुहोस ', fontWeight: FontWeight.w700, size: 32.0.sp, color: Colors.black, ),
//               SizedBox(height: 40.0.h,),
//               CustomTextField(controller:controller.numberOfRoomController, hint: 'NumberOfRooms', prefixIcon: SvgPicture.asset('assets/images/Vector1.svg'), validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               CustomTextField(controller:controller.electricityController, hint: 'Electricity', prefixIcon: SvgPicture.asset('assets/images/Vector1.svg'), validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               CustomTextField(controller:controller.waterController, hint: 'Water', prefixIcon: SvgPicture.asset('assets/images/Vector2.svg'),validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               CustomTextField(controller:controller.wasteController, hint: 'Waste', prefixIcon: SvgPicture.asset('assets/images/bag.svg'),validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               CustomTextField(controller:controller.wifiController, hint: 'Wifi', prefixIcon: Icon(Icons.wifi, color: AppColor.primarycolor,), validator: Validator.checkNumberField, textInputType: TextInputType.number,),
//               CustomTextField(controller:controller.otherServicesController, hint: 'Other Services', prefixIcon: Icon(Icons.cleaning_services, color: AppColor.primarycolor,),textInputType: TextInputType.number,)
//             ],
//           ),
//         )
//     )
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async=>false,
//       child: SafeArea(
//         child: Scaffold(
//           body: Theme(
//             data: ThemeData(colorScheme: ColorScheme.light(primary: AppColor.primarycolor)),
//             child: Stepper(
//               type: StepperType.horizontal,
//               currentStep: _index,
//               steps: steps(),
//               onStepContinue: () async{
//                 if(!formKeys[_index].currentState!.validate()){
//                   return;
//                 }
//                 if(_index == 1 ){
//                   CreateGharbeti(context, gharbetiName: controller.gharbetiName.text, houseNumber: controller.houseNumberController.text, userEmail: controller.gharbetiEmailController.text, city: controller.cityController.text, location: controller.addressController1.text);
//
//                   return ;
//                   // print('hello');
//                   // return ;
//                   // if(formKeys[1].currentState!.validate()){
//                   //
//                   //   controller.CreateGharbeti(context, gharbetiName: controller.gharbetiName.text, houseNumber: controller.houseNumberController.text, userEmail: controller.gharbetiEmailController.text, city: controller.cityController.text, location: controller.addressController1.text);
//                   // }
//                 }
//                 if(_index < (steps().length - 1 )) {
//                   setState(() {
//                     _index += 1;
//                   });
//                 }
//
//
//                 if(_index ==2 && !!formKeys[_index].currentState!.validate()) {
//                   controller.createSettings(context,no_of_rooms: controller.numberOfRoomController.text, water: controller.waterController.text, wifi: controller.wifiController.text, waste: controller.wasteController.text, otherServices: controller.otherServicesController.text, electricity_rate: controller.electricityController.text);
//                   final SharedPreferences prefs = await SharedPreferences.getInstance();
//                   prefs.setString('waterCharges', controller.waterController.text);
//                   prefs.setString('wasteCharges', controller.wasteController.text);
//                   prefs.setString('username', controller.nameController.text);
//                   return ;
//                 }
//               },
//               onStepCancel: (){
//                 if(_index == 0) {
//                   return;
//                 }
//                 setState(() {
//                   _index -=1;
//                 });
//               },
//               onStepTapped: (int index){
//                 if(formKeys[_index].currentState!.validate()) {
//                   setState(() {
//                     _index = index;
//                   });
//                 }
//
//
//               },
//               controlsBuilder: (context, ControlsDetails controls ) {
//                 final isLastStep = _index == steps().length-1;
//                 return Container(
//                   margin: EdgeInsets.only(top: 20),
//                   child: Row(
//                     children: [
//
//                       Expanded(child:
//                       Row(
//                         children: [
//                           // CustomButton(text: 'Location', onPressed: _getCurrentPosition),
//                           Expanded(child: CustomButton(text: 'CANCEL', onPressed: controls.onStepCancel, height: 135.h, width: 35.w,)),
//                           // CustomButton(text: 'text')
//                           SizedBox(width: 12.0,),
//                           // Text(passArgument ?? ''),
//                             Expanded(child:CustomButton(text: isLastStep ? 'CONFIRM' : 'NEXT', onPressed: controls.onStepContinue, height: 135.h, width: 35.w, ), ),
//                         ],
//                       )
//
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
