import 'package:flutter/material.dart';
import 'package:ifood_delivery/pages/auth/sign_up_page.dart';
import 'package:ifood_delivery/pages/home/main_food_page.dart';
import 'package:ifood_delivery/pages/order/order_page.dart';
import 'package:ifood_delivery/utils/colors.dart';

import '../account_page/account_page.dart';
import '../auth/sign_in_page.dart';
import '../cart/cart_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _seletectedIndex = 0;
  List pages = [
    MainFoodPage(),
    OrderPage(),
    CartHistory(),
    AccountPage(),
  ];

  void onTapNav(int index){
    setState(() {
      _seletectedIndex = index;
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_seletectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _seletectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.1,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account"
          ),
        ],
      ),
    );
  }
}
