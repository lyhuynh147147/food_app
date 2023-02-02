import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/controllers/auth_controller.dart';
import 'package:ifood_delivery/controllers/order_controller.dart';
import 'package:ifood_delivery/pages/order/order_view.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/styles.dart';

import '../../base/custom_app_bar.dart';
import '../../utils/dimensions.dart';
import '../auth/sign_in_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();

    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn) {
      _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Đơn hàng của tôi',
      ),
      body: _isLoggedIn ? GetBuilder<OrderController>(
        builder: (orderController) {
          return Column(children: [

            Center(
              child: Container(
                width: Dimensions.screenWidth,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.fontSizeSmall),
                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(context).primaryColor),
                  tabs: [
                    Tab(text: 'Đang chờ'.tr),
                    Tab(text: 'Lịch sử'.tr),
                  ],
                ),
              ),
            ),

            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                OrderView(isRunning: true),
                OrderView(isRunning: false),
              ],
            )),

          ]);
        },
      ) : SignInPage(),
    );
  }
}
