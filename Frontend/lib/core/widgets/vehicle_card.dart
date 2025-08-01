import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleCard extends StatelessWidget{
  final String vehicleName;
  final String img;
  final Function(String value) onChanged; 
  final String selectedVehicle;
  const VehicleCard({
    super.key,
    required this.vehicleName,
    required this.img,
    required this.onChanged,
    required this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
      side: BorderSide(
        color: selectedVehicle == vehicleName ? Theme.of(context).colorScheme.primary : Colors.transparent,
        width: 1.5.w,
      )
     ),
     child: RadioListTile(
      value: vehicleName,
       groupValue: selectedVehicle,
        onChanged: (value) {
          onChanged(value!);

        },
        controlAffinity: ListTileControlAffinity.trailing,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Image.asset(
              img,
              width: 53.w,
              height: 55.h,
            ),
            SizedBox(width: 20.w),
            Text(
              vehicleName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          ]
        ),
        )
    );
  }
}