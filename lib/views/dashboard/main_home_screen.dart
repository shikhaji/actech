import 'package:ac_tech/views/dashboard/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/drawer_widget.dart';
import 'categories_screen.dart';
import 'home_screen.dart';
import 'my_order_screen.dart';

class MainHomeScreen extends StatefulWidget {
  final index;
  MainHomeScreen({Key? key,required this.index}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;
  bool isMenuOpen = false;
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.index != 0) {
      _selectedIndex = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: _buildBody(currentIndex),
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
          bottomNavigationBar: PrimaryBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(int _selectedIndex) {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const CategoriesScreen();
      case 2:
        return const MyOrderScreen();
      case 3:
        return const ProfileScreen();
      default:
    }
    return Container();
  }
}


// import 'package:ac_tech/utils/app_assets.dart';
// import 'package:ac_tech/views/dashboard/profile_screen.dart';
// import 'package:bottom_bar/bottom_bar.dart';
// import 'package:flutter/material.dart';
// import '../../utils/app_color.dart';
// import 'categories_screen.dart';
// import 'home_screen.dart';
// import 'my_order_screen.dart';
//
// class MainHomeScreen extends StatefulWidget {
//   final index;
//   MainHomeScreen({Key? key, required this.index}) : super(key: key);
//
//   @override
//   State<MainHomeScreen> createState() => _MainHomeScreenState();
// }
//
// class _MainHomeScreenState extends State<MainHomeScreen> {
//   final controller = PageController();
//   var selectedIndex=0;
//   List pages = [
//     HomeScreen(),
//     CategoriesScreen(),
//     MyOrderScreen(),
//     ProfileScreen()
//   ];
//
//   void onTap(int index){
//     setState(() {
//       selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],
//       bottomNavigationBar: BottomBar(
//         textStyle: TextStyle(fontWeight: FontWeight.bold),
//         selectedIndex: selectedIndex,
//         onTap: onTap,
//         items: <BottomBarItem>[
//           BottomBarItem(
//             icon: ImageIcon(AssetImage(AppAsset.homeFill)),
//
//             activeColor: AppColor.primaryColor,
//             activeTitleColor: AppColor.primaryColor,
//           ),
//           BottomBarItem(
//             icon: ImageIcon(AssetImage(AppAsset.categoryFill)),
//             title: Text('Courses'),
//             activeColor: AppColor.primaryColor,
//             activeTitleColor: AppColor.primaryColor,
//           ),
//           BottomBarItem(
//             icon: ImageIcon(AssetImage(AppAsset.bookmarkFill)),
//             title: Text('My Class'),
//             backgroundColorOpacity: 0.1,
//             activeColor: AppColor.primaryColor,
//           ),
//           BottomBarItem(
//             icon: ImageIcon(AssetImage(AppAsset.userProfileFill)),
//             title: Text('Profile'),
//             activeColor: AppColor.primaryColor,
//             activeTitleColor: AppColor.primaryColor,
//           ),
//         ],
//       ),
//     );
//   }
// }