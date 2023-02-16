import 'package:ac_tech/services/api_services.dart';
import 'package:ac_tech/widgets/primary_appbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import '../../routes/arguments.dart';
import '../../services/shared_preferences.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/image_utils.dart';
import '../../utils/validation_mixin.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_size_box.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/primary_textfield.dart';
import '../../widgets/scrollview.dart';

class EditProfile extends StatefulWidget {
  final OtpArguments? arguments;
  const EditProfile({Key? key, this.arguments}) : super(key: key);


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with ValidationMixin {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referCode = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("${widget.arguments?.phoneNumber}");
    getData();
  }
  Future getData() async {
    Future.delayed(Duration(seconds: 3)).then((value) async {
      String? id = await Preferances.getString("userId");
      String? token = await Preferances.getString("Token");
      print("userId:=${id}");
      print("token:=${token}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Edit Profile",
        isLeading: true,
        leadingIcon: Icons.arrow_back_sharp,
      ),
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: Form(
            key: _formKey,
            child: CustomScroll(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxH34(),
                Center(
                  child: Image.asset(
                    AppAsset.splashImage,
                    height: 20.h,
                  ),
                ),
                SizedBoxH28(),
                appText("Edit Profile", style: AppTextStyle.title),
                SizedBoxH28(),
                appText("Name", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _name,
                  validator: nameValidator,
                  prefix: const Icon(Icons.perm_identity),
                  hintText: "Enter your name",
                ),
                SizedBoxH10(),
                appText("Phone number", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _phone,
                  readOnly: true,
                  validator: mobileNumberValidator,
                  prefix: const Icon(Icons.phone),
                  hintText: "Enter Phone number",
                ),
                SizedBoxH10(),
                appText("Email id", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _email,
                  keyboardInputType: TextInputType.emailAddress,
                  validator: emailValidator,
                  prefix: const Icon(Icons.email),
                  hintText: "Enter your email",
                ),
                SizedBoxH10(),
                SizedBoxH14(),

                PrimaryButton(
                    lable: "Update",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FormData data() {
                          return FormData.fromMap({
                            "name": _name.text.trim(),
                            "email": _email.text.trim(),
                            "mobile": _phone.text.trim(),
                            "password": _password.text.trim(),
                            "referal_code": _referCode.text.trim(),
                          });
                        }
                        ApiService().signUp(context,data:data());
                      }
                    }),
              ],
            ),
          )),
    );
  }
}
