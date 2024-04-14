import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserRecordTile extends StatefulWidget {
  final String? dateTitle;
  final String? doctorName;
  final String? status;
  final String? startTime;
  final void Function() onViewDetails;
  UserRecordTile({
    Key? key,
    required this.dateTitle,
    required this.startTime,
    required this.doctorName,
    required this.status,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  State<UserRecordTile> createState() => _UserRecordTileState();
}

class _UserRecordTileState extends State<UserRecordTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.5.h),
      child: GestureDetector(
        onTap: widget.onViewDetails,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors
                    .black, // Adjust the shadow color and opacity as needed
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    Offset(-4, 0), // Offset to create a shadow on the left side
              ),
            ],
            border: Border(
              left: BorderSide(
                color: Colors.black, // Amber color for the left border
                width: 2, // Adjust the border width as needed
              ),
            ),
          ),
          height: Get.height / 4.6,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        widget.dateTitle ?? "",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    widget.startTime ?? "",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(widget.doctorName ?? ""),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Divider(
                thickness: 1.0,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.status ?? ""),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
