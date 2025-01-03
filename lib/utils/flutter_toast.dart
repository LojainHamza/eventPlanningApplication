import 'package:event_planning_app/utils/MyAppColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage{
  static Future <bool?>toastMessage({required String msg}){
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: MyAppColors.redColor,
        textColor: MyAppColors.whiteColor,
        fontSize: 20
    );
  }
}