import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gharbeti/utils/sharedPreferences.dart';
import 'package:gharbeti/widget/CustomAppBar.dart';
import 'package:gharbeti/widget/CustomButton.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/roomController.dart';
import '../../controller/steper_controller.dart';
import '../../widget/CustomTextField.dart';
import '../../widget/color.dart';

class EditGharscreen extends StatefulWidget {
  const EditGharscreen({Key? key}) : super(key: key);

  @override
  State<EditGharscreen> createState() => _EditGharscreenState();
}

class _EditGharscreenState extends State<EditGharscreen> {
  final controller = Get.put(SteperController());
  void getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      controller.electricityController.text = SharedData.getElectricity();
      controller.waterController.text = SharedData.getWater();
      controller.wasteController.text = SharedData.getWaste();
      controller.wifiController.text = SharedData.getWifi();
      controller.otherServicesController.text = SharedData.getOtherServices();
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
      appBar: CustomAppBar(title: 'Edit Ghar Settings',),
      body: Container(
        child: Column(
          children: [
            CustomTextField(controller: controller.electricityController, hint: 'Electricity', prefixIcon: SvgPicture.asset('assets/images/Vector1.svg'),textInputType: TextInputType.number,),
            CustomTextField(controller: controller.waterController, hint: 'Water', prefixIcon: SvgPicture.asset('assets/images/Vector2.svg'), textInputType: TextInputType.number,),
            CustomTextField(controller:controller.wasteController, hint: 'Waste', prefixIcon: SvgPicture.asset('assets/images/bag.svg'), textInputType: TextInputType.number,),
            CustomTextField(controller: controller.wifiController, hint: 'Wifi', prefixIcon: Icon(Icons.wifi, color: AppColor.primarycolor,),textInputType: TextInputType.number,),
            CustomTextField(controller: controller.otherServicesController, hint: 'Other Services', prefixIcon: Icon(Icons.cleaning_services, color: AppColor.primarycolor,),textInputType: TextInputType.number,),
            CustomButton(text: 'Update Ghar', height: 135.h, width: 35.w, onPressed: () {
              controller.updateGhar(context,electricity_rate: controller.electricityController.text, water: controller.waterController.text, waste: controller.wasteController.text, wifi: controller.wifiController.text, otherServices: controller.otherServicesController.text );
            },)
          ],
        ),
      ),
    );
  }
}
