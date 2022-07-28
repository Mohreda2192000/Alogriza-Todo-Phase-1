import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextForm extends StatelessWidget {
  final String label;
  final String hint;
  final Widget ?widget;
  final TextEditingController controller;
  final TextInputType inputType;
  final String validator;
  final bool isValidation;

  const MyTextForm({Key? key,
    required this.label,
    required this.hint,
    this.widget,
    required this.controller,
    this.inputType=TextInputType.text,
    this.validator="",
    this.isValidation=true,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h,),
          Container(
            padding: EdgeInsets.only(left:14.h),
            width: double.infinity,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Colors.grey,
                    controller: controller,
                    keyboardType: inputType,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[800],
                    ),
                    validator: (value) {
                      if (value!.isEmpty&&isValidation) {
                        return validator;
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget??Container(),
                //widget==null?Container():widget!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
