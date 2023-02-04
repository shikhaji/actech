import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_utils.dart';
import '../utils/font_utils.dart';

class CustomAppBar extends StatefulWidget {
  final String? title;
  final String? tooltip;
  const CustomAppBar({Key? key,this.title, this.tooltip}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child:Scaffold(

          appBar: AppBar(
            title:Text("${widget.title ?? ""}",
                style: FontTextStyle.poppinsS14W7BlackColor),
            leading: const BackButton(color: Colors.black54),
            backgroundColor: ColorUtils.appBgColor,
            elevation: 1,
          ),
        ),
    );
  }
}
