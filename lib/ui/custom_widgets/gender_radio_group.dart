import 'package:flutter/material.dart';
import 'package:flutter_antonx_boilerplate/ui/custom_widgets/single_radio_button.dart';
import 'package:get/get.dart';

class GenderRadioGroup extends StatelessWidget {
  final model;

  GenderRadioGroup(this.model);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "gender".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
        SizedBox(
          width: 40,
        ),
        // Radio(
        //   value: 0,
        //   activeColor: primaryColor,
        //   groupValue:
        //       model.selectedGenderIndex,
        //   onChanged: (val) {
        //     model.updateIndex(val);
        //   },
        // ),
        CustomSingleRadioButton(
          isSelected: model.selectedGenderIndex == 0,
          onPressed: () {
            print('Update Gender Index to 0');
            model.updateIndex(0);
          },
        ),
        Text(
          "male".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        // Radio(
        //   value: 1,
        //   activeColor: primaryColor,
        //   groupValue: model.selectedGenderIndex,
        //   onChanged: (val) {
        //     model.updateIndex(val);
        //   },
        // ),
        CustomSingleRadioButton(
          isSelected: model.selectedGenderIndex == 1,
          onPressed: () {
            debugPrint('Update Gender Index to 1');
            model.updateIndex(1);
          },
        ),
        Text(
          "female".tr,
          // style: textStyleWithHacenFont.copyWith(
          //     fontSize: ScreenUtil().setSp(12), color: Colors.white),
        ),
      ],
    );
  }
}
