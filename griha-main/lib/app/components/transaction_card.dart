import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:griha/app/models/bookings.dart';
import 'package:griha/app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:sizer/sizer.dart';

class TransactionCard extends StatelessWidget {
  final Bookings booking;
  const TransactionCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(
        horizontal: 1.w,
        vertical: 1.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
        vertical: 5.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                DateFormat(DateFormat.DAY).format(booking.createdAt!),
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateFormat(DateFormat.MONTH).format(booking.createdAt!),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        booking.title ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Rs: ${booking.price}',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                booking.streetAddress ?? '',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                ('${DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(booking.startDate!)} - ${DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(booking.endDate!)}'),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Text(
                    'Payment status: ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        booking.isPaid == 1 ? 'Paid' : 'Not Paid',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(
                        booking.isPaid == 1
                            ? Icons.check_circle
                            : Icons.pending_actions_outlined,
                        color: booking.isPaid == 1 ? Colors.green : Colors.red,
                        size: 15.sp,
                      ),
                    ],
                  ),
                ],
              ),
              booking.isPaid == 0
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 2.h,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Payment Details',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.w,
                                      ),
                                      SizedBox(
                                        height: 10.w,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Payment status: ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  booking.isPaid == 1
                                                      ? 'Paid'
                                                      : 'Not Paid',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                Icon(
                                                  booking.isPaid == 1
                                                      ? Icons.check_circle
                                                      : Icons
                                                          .pending_actions_outlined,
                                                  color: booking.isPaid == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                                  size: 15.sp,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.w,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Payment Mode: ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              booking.paymentMode ?? '',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Mobile: ',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                            child: Text(
                                              '${getPaymentSuccessModel(booking.additionalPaymentData!).mobile} ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.5.w,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Transaction ID: ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7.5.w,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${getPaymentSuccessModel(booking.additionalPaymentData!).idx} ',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                        ),
                        child: Text(
                          'View details',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
