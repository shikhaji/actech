import 'dart:convert';

import 'package:ac_tech/services/api_services.dart';
import 'package:ac_tech/utils/app_color.dart';
import 'package:ac_tech/utils/app_text_style.dart';
import 'package:ac_tech/widgets/app_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/my_order_list_model.dart';
import '../../routes/arguments.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_sizes.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class PaymentDes extends StatefulWidget {
  final OtpArguments? arguments;
  const PaymentDes({Key? key, this.arguments}) : super(key: key);

  @override
  State<PaymentDes> createState() => _PaymentDesState();
}


class _PaymentDesState extends State<PaymentDes> {
  List<GetOrderList> getOrderList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    callApi();

  }

  String loginId ="";

  GetOrderListModel? getOrderListModel;
  void callApi() async{
    String? id = await Preferances.getString("userId");
    print("loginid: ${id}");
    print("loginid: ${id}");

    Map<String,dynamic> data = {
      "login_id":id!.replaceAll('"', '').replaceAll('"', '').toString(),
      "cc_id" :widget.arguments!.ccId,
    };

   ApiService().getOrderListAPi(context,data:data).then((value) {
     if(value != null){
       setState(() {

          getOrderListModel = GetOrderListModel.fromJson(jsonDecode(value));



       });
       print("getOrderList:=${getOrderListModel!.course!.length}");
       print("getOrderList:=${getOrderListModel!.course![0].cCFVNAME}");
     }
   });
  }

  // Future<void> getId()async {
  //   String? id = await Preferances.getString("userId");
  //   print("login id here is:000${id}");
  // setState(() {
  //
  //    loginId = "$id";
  // });


  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            SizedBoxH34(),
            appText("Transaction Details",style: AppTextStyle.headingTextTile),
            SizedBoxH20(),
            Center(
              child: DataTable(
                border: TableBorder.all(

                    color: AppColor.black,
                    style: BorderStyle.solid,
                    width: 1),
                columns: const [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Description')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("Name:")),
                    DataCell(Text("${getOrderListModel != null && getOrderListModel!.course != null ? getOrderListModel!.course![0].cCFVNAME : ""}")),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Payment Date:')),
                    DataCell(Text('${getOrderListModel != null && getOrderListModel!.course != null ? getOrderListModel!.course![0].pLCPAYMENTDATE : ""}')),

                  ]),
                  DataRow(cells: [
                    DataCell(Text('Amount:')),
                    DataCell(Text('${getOrderListModel != null && getOrderListModel!.course != null ? getOrderListModel!.course![0].cCFVCOMMISION : ""}')),

                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Transaction Id:')),
                    DataCell(Text('${getOrderListModel != null && getOrderListModel!.course != null ? getOrderListModel!.course![0].pLCTRANSACTIONID : ""}')),

                  ]),
                ],
              ),
            ),
            

          ],
        ),
        appBar: const SecondaryAppBar(
          title: "Payment Description",
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          
        ));
  }
}
