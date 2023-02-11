import 'package:ac_tech/widgets/custom_size_box.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/primary_appbar.dart';
import '../../widgets/scrollview.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  final TextEditingController _search = TextEditingController();
  // int _selectedSliderIndex = 0;
  List sliderImageList = [];
  List latestNewsList = [];
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          elevation: 0,
          width: ScreenUtil().screenWidth * 0.8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Sizes.s20.r),
              bottomRight: Radius.circular(Sizes.s20.r),
            ),
          ),
          child: const DrawerWidget(),
        ),
        body: CustomScroll(
          children: [
            SizedBoxH34(),
            Center(
              child: Container(
                  height: Sizes.s100.h,
                  width: Sizes.s100.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(AppAsset.userImage),
                        fit: BoxFit.cover,
                        ))),
            ),
             SizedBoxH10(),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Provisioning Tech",
                  style: AppTextStyle.headingTextTile2
                      .copyWith(fontSize: Sizes.s22),
                ),
                Text(
                  "Provisioning@gmail.com",
                  style: AppTextStyle.lable.copyWith(fontSize: Sizes.s16),
                )
              ],
            ),
            SizedBoxH20(),
            SizedBoxH20(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.textFieldColor,
                borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'Edit Profile',
                onTap: () {},
                child: Icon(Icons.perm_identity),
              ),
            ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'FAQ',
                onTap: () {
                  Navigator.pushNamed(context, Routs.fquestion);
                },
                child: Icon(Icons.format_list_bulleted_sharp),
              ),
            ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'My Order',
                onTap: () {},
                child: Icon(Icons.format_list_bulleted_sharp),
              ),
            ),
        SizedBoxH18(),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.textFieldColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: _ProfileListTile.asset(
            title: 'Terms & Conditions',
            onTap: () {},
            child: Icon(Icons.local_police_outlined),
          ),
        ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'Privacy Policy',
                onTap: () {
                  // Navigator.pushNamed(context, Routs.privacyPolicy);
                },
                child: Icon(Icons.policy),
            ),
            ),
            SizedBoxH18(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: _ProfileListTile.asset(
                title: 'About Us',
                onTap: () {},
                child: const Icon(Icons.account_box),
              ),
            ),
          ],
        ),
        appBar: SecondaryAppBar(
          title: "Profile",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
  }
}

class _ProfileListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _ProfileListTile.asset({
    required this.onTap,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style: AppTextStyle.lable,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}