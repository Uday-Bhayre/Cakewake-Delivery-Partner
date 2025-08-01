import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget{


  final List<String> items;
  final String hintText;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

   const CustomDropDown({
    super.key,
    required this.items,
    required this.hintText,
    required this.onChanged,
     required this.validator,
  });

  @override
  Widget build (BuildContext context){
     return SizedBox(
      width: 358.w,
       child: DropdownButtonFormField<String>(
        
         items: items.map((item) {
           return DropdownMenuItem<String>(
             value: item,
             child: Text(item),
           );
         }).toList(),
         hint: Text(hintText),
         onChanged: onChanged,
         validator: validator,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         decoration: InputDecoration(
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(13.r),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(13.r),
             borderSide: BorderSide(
               color: Theme.of(context).colorScheme.primary,
               width: 1.5.w,
             ),
           ),
         ),
       ),
     );
  }
}