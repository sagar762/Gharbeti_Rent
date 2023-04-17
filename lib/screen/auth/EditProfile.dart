import 'package:flutter/material.dart';
import 'package:gharbeti/screen/home/ProfileScreen.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:gharbeti/widget/CustomTextField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/signupController.dart';
import '../../widget/color.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final controller = Get.put(SignUpController());
  void getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      controller.nameController.text = SharedData.getUserName();
      controller.emailController.text = SharedData.getEmail();
      controller.locationController?.text = SharedData.getUserCity();
      controller.phoneNoController.text = SharedData.getPhoneNumber();

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
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile',),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              CustomTextField(controller: controller.nameController, hint: 'Name', prefixIcon: Icon(Icons.person, color: AppColor.primarycolor,), ),
              // SizedBox(height: 5.0,),
              CustomTextField(controller: controller.emailController, hint: 'Email', prefixIcon: Icon(Icons.email, color: AppColor.primarycolor,)),
              CustomTextField(controller: controller.phoneNoController, hint: 'Phone Number', prefixIcon: Icon(Icons.phone, color: AppColor.primarycolor,),textInputType:TextInputType.phone,),
              CustomTextField(controller: controller.locationController, hint: 'Address', prefixIcon: Icon(Icons.location_on, color: AppColor.primarycolor,),),
              SizedBox(height: 40.h,),
              CustomButton(text: 'Update Profile', height: 135.h, width: 35.w, onPressed: (){
                  controller.updateProfile(context, name: controller.nameController.text, email: controller.emailController.text, phoneNumber: controller.phoneNoController.text, address: controller.locationController?.text);

              },)
            ],
          ),
        ),
      ),
    );
  }
}
