import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkTimingCard extends StatelessWidget{
  final String workTiming;
  final Function(String value) onChanged; 
  final String selectedWorkTiming;
  const WorkTimingCard({
    super.key,
    required this.workTiming,
    required this.onChanged,
    required this.selectedWorkTiming,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
      side: BorderSide(
        color: selectedWorkTiming == workTiming ? Theme.of(context).colorScheme.primary : Colors.transparent,
        width: 1.5.w,
      )
     ),
     child: RadioListTile(
      value: workTiming,
       groupValue: selectedWorkTiming,
        onChanged: (value) {
          onChanged(value!);

        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          workTiming,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      subtitle: Text(
        '6 days a week',
        style: TextStyle(
          fontSize: 14.sp,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
     )
    );
  }
}