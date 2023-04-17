
import 'package:get/get.dart';

class Validator{
  static String? checkFieldEmpty(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? checkPhoneField(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    } else if (!(fieldContent.isNumericOnly && fieldContent.length == 10)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? checkNumberField(String? fieldContent) {
    if(fieldContent!.isEmpty) {
      return 'This field is required';
    } else if(!(fieldContent.isNumericOnly)){
      return 'Invalid Number';
    }
    return null;
  }


  static String? checkEmailField(String? fieldContent) {
    if (fieldContent!.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(fieldContent)) {
      return 'Invalid email address';
    }
    return null;
  }
}