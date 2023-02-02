import 'package:get/get.dart';

class Dimensions {

  static double screenHight = Get.context!.height;
  static double screenWidth = Get.context!.width; // 411.42857142857144

  static double pageViewContainer = screenHight / 3.106493506494155; // 220
  static double pageViewTextContainer = screenHight / 5.695238095239283; // 120
  static double pageView = screenHight / 2.135714285714731; // 320

// dynamic height
  static double height1 = screenHight / 683.4285714285714;
  static double height10 = height1 * 10;
  static double height15 = height10 * 1.5;
  static double height20 = height10 * 2;
  static double height30 = height10 * 3;
  static double height24 = height10 * 2.4;
  static double height45 = height10 * 4.5;
  static double height40 = height10 * 4.0;
  static double height50 = height10 * 5.0;
  static double height60 = height10 * 6.0;
  static double height80 = height1 * 80.0;
  static double height2 = height1 * 2;
  static double height3 = height1 * 3;
  static double height5 = height1 * 5;
  static double height700 = height1 * 700;
  static double height120 = height1 * 120;
  static double height110 = height1 * 110;
  static double height100 = height1 * 100;
  static double height105 = height1 * 105;
  static double height350 = height1 * 350;

  static double height275 = height1 * 275;
  static double height265 = height1 * 265;

  // dynamic width
  static double width1 = screenWidth / 411.42857142857144;
  static double width10 = width1 * 10;
  static double width5 = width1 * 5;
  static double width15 = width10 * 1.5;
  static double width20 = width10 * 2;
  static double width30 = width10 * 3;
  static double width45 = width10 * 4.5;
  static double width100 = width1 * 100;
  static double width120 = width1 * 120;
  static double width200 = width1 * 200;

  static double font20 = height20;
  static double font15 = height15;
  static double font16 = height1 * 16;
  static double font24 = height24;
  static double font1 = height1;
  static double font26 = font1 * 26;

  static double radius20 = height20;
  static double radius30 = height30;
  static double radius5 = height10 / 2;

  // List View Size
  static double listViewImgSize = width1 * 120; // 120
  static double listViewTextContSize = height1 * 105; //100

  // Popular Food Image
  static double popularFoodImgSize = height350;

  // Icon size
  static double iconSize16 = height1 * 16;
  static double iconSize24 = height10 * 2.4;

  // Bottom height
  static double bottomHeightBar = height1 * 120;

  static double screenHeight = Get.context!.height;
//   static double screenWidth = Get.context!.width;
// //683/210=3.25
//
//   static double pageView = screenHeight/2.64;
//   static double pageViewContainer = screenHeight/3.84;
//   static double pageViewTextContainer = screenHeight/7.03;
//   //height
//   static double height10 = screenHeight/84.4;
//   static double height15 = screenHeight/56.27;
//   static double height20 = screenHeight/42.2;
//   static double height30 = screenHeight/28.13;
//   static double height45 = screenHeight/18.7;
//
//   //width
//   static double width10 = screenHeight/84.4;
//   static double width15 = screenHeight/56.27;
//   static double width20 = screenHeight/42.2;
//   static double width30 = screenHeight/28.13;
//
//
//   static double font16 = screenHeight/52.75;
//   static double font20 = screenHeight/42.2;
//   static double font26 = screenHeight/32.46;
//
  static double radius15 = screenHeight/56.27;
//  static double radius20 = screenHeight/42.2;
//  static double radius30 = screenHeight/28.13;
//
//   static double iconSize24 = screenHeight/35.17;
//   static double iconSize16 = screenHeight/52.75;
//
//   static double listViewImgSize = screenWidth/3.25;
//   static double listViewTextContSize= screenWidth/3.9;
//
//   static double popularFoodImgSize = screenHeight/2.41;
//
//   static double bottomHeightBar = screenHeight/7.01;

  //



  static double size300 = screenHeight / 2.28;
  static double size285 = screenHeight / (screenHeight / 285);
  static double size210 = screenHeight / 3.25;
  static double size260 = screenHeight / 2.63;
  static double size120 = screenHeight / 5.69;
  static double size110 = screenHeight / (screenHeight / 110);
  static double size100 = screenHeight / 6.83;
  static double size5 = screenHeight / 136.6;
  static double size10 = screenHeight / 68;
  static double size15 = screenHeight / 45;
  static double size20 = screenHeight / 34.15;
  static double size25 = screenHeight / (screenHeight / 25);
  static double size30 = screenHeight / 22.77;
  static double size45 = screenHeight / 15.18;



  static double splashImg = screenHeight/7.03;

  static double fontSizeExtraSmall = Get.context!.width >= 1170 ? 16 : 10;
  static double fontSizeSmall = Get.context!.width >= 1170 ? 18 : 12;
  static double fontSizeDefault = Get.context!.width >= 1170 ? 26 : 20;
  static double fontSizeLarge = Get.context!.width >= 1170 ? 22 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1170 ? 24 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1170 ? 30 : 24;

  //screen size and width based on context
  static double screenSizeWidth=Get.context!.width;
  static double screenSizeHeight = Get.context!.height;

  static const double PADDING_SIZE_EXTRA_SMALL = 5.0;
  static const double PADDING_SIZE_SMALL = 10.0;
  static const double PADDING_SIZE_DEFAULT = 15.0;

  static const double PADDING_SIZE_EXTRA_LARGE = 25.0;


  static const double VIEW_PORT_MOBILE=0.85;
  static const double VIEW_PORT_DESKTOP=0.74;
  static const double LIST_VIEW_CON_SIZE_MOBILE=120;
  static const double LIST_VIEW_CON_SIZE_DESKTOP=200;
  static const double LIST_VIEW_CON_SIZE=100;
  static const double LIST_VIEW_CON_DESKTOP=160;

  //common app marig or padding
  static double appMargin=screenSizeWidth>WEB_MAX_WIDTH?MARGIN_SIZE_EXTRA_LARGE:screenSizeWidth/18.75;
  static double sizedBoxHeight = screenSizeWidth>WEB_MAX_WIDTH?20:screenSizeWidth/12.5;
  static double viewPort = screenSizeWidth>WEB_MAX_WIDTH?VIEW_PORT_DESKTOP:VIEW_PORT_MOBILE;
  static double listViewImg=
  screenSizeWidth>WEB_MAX_WIDTH?LIST_VIEW_CON_SIZE_DESKTOP:screenSizeWidth/3.12;

  static double listViewCon=
  screenSizeWidth>WEB_MAX_WIDTH?LIST_VIEW_CON_SIZE_DESKTOP-40:screenSizeWidth/3.75;

  //page view
  static const double PAGE_VIEW_CON=500;
  static const double PAGE_VIEW_CON_DESK=600;
  static const double PAGE_VIEW_CON_TEXT=150;
  static  double pageViewCon=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON_DESK:screenSizeHeight/2.64;

  static double pageViewInnerCon=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON:screenSizeHeight/3.83;
  static double pageViewInnerConText=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON_TEXT:screenSizeHeight/7.03;

  //detail food
  static const double DETAIL_FOOD_IMG=400;

  static double detailFoodImg=screenSizeWidth>WEB_MAX_WIDTH?double.maxFinite-400:screenSizeHeight/2.11;
  static double detailFoodImgWidth=screenSizeWidth>WEB_MAX_WIDTH?double.maxFinite-400:double.maxFinite;
  static double detailFoodImgPad=screenSizeWidth>WEB_MAX_WIDTH?MARGIN_SIZE_EXTRA_LARGE:0;

  //page view
  static const double MORE_VIEW_CON=500;
  static const double MORE_VIEW_CON_DESK=400;
  static const double MORE_VIEW_CON_TEXT=150;
  static  double moreViewCon=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON_DESK:screenSizeHeight/2.64;

  static double moreViewInnerCon=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON:screenSizeHeight/3.83;
  static double moreViewInnerConText=screenSizeWidth>WEB_MAX_WIDTH?PAGE_VIEW_CON_TEXT:screenSizeHeight/7.03;

  //top bar home page
  static const double TOP_BAR_WEB=15;
  static const double TOP_BAR_MOB=60;
  static double topBar=screenSizeWidth>WEB_MAX_WIDTH?TOP_BAR_WEB:TOP_BAR_MOB;
  //bottom buttons
  static const double BUTTOM_BUTTON_CON=120;
  static double buttonButtonCon=screenSizeWidth>WEB_MAX_WIDTH?BUTTOM_BUTTON_CON:screenSizeHeight/6.63;



  static const double RADIUS_SMALL = 5.0;
  static const double RADIUS_DEFAULT = 10.0;
  static const double RADIUS_LARGE = 15.0;
  static const double WEB_MAX_WIDTH = 1170;
  static bool isWeb=screenSizeWidth>WEB_MAX_WIDTH?true:false;
  static  double SPLASH_IMG_WIDTH=screenSizeWidth>WEB_MAX_WIDTH?500:250;
  static const double PADDING_SIZE_LARGE = 20.0;
  //dynamic padding
  static const double PADDING_SIZE_5=5.0;
  static const double PADDING_SIZE_20 = 20.0;
  static const double PADDING_SIZE_30 = 30.0;
  static const double PADDING_SIZE_40 = 40.0;
  static double padding5=screenSizeWidth>WEB_MAX_WIDTH?PADDING_SIZE_5:screenSizeHeight/168.8;
  static double padding20=screenSizeWidth>WEB_MAX_WIDTH?PADDING_SIZE_20:screenSizeHeight/42.2;
  static double padding30=screenSizeWidth>WEB_MAX_WIDTH?PADDING_SIZE_30:screenSizeHeight/28.13;
  static double padding40=screenSizeWidth>WEB_MAX_WIDTH?PADDING_SIZE_40:screenSizeHeight/21.10;
  static double padding10=screenSizeWidth>WEB_MAX_WIDTH?PADDING_SIZE_SMALL:screenSizeHeight/84.4;


  //dynamic margin
  static const double MARGIN_SIZE_EXTRA_LARGE = 200.0;
  static const double MARGIN_SIZE_80 = 80.0;
  static const double MARGIN_SIZE_40 = 40.0;
  static const double MARGIN_SIZE_35=35.0;
  static const double MARGIN_SIZE_30=30.0;
  static double margin40=screenSizeWidth>WEB_MAX_WIDTH?MARGIN_SIZE_40:screenSizeHeight/21.1;
  static double margin80=screenSizeWidth>WEB_MAX_WIDTH?MARGIN_SIZE_80:screenSizeHeight/10.55;
  static double margin35=screenSizeWidth>WEB_MAX_WIDTH?MARGIN_SIZE_35:screenSizeHeight/24.11;


  //dynamic font
  static double font18=screenSizeWidth>WEB_MAX_WIDTH?18:screenSizeHeight/70.33;
  static double font22=screenSizeWidth>WEB_MAX_WIDTH?22:screenSizeHeight/38.36;
  static double font30=screenSizeWidth>WEB_MAX_WIDTH?30:screenSizeHeight/28.13;

  //dynamic sliver height
  static const double SLIVER_HEIGHT=350;
  static const double SLIVER_IMG=300;
  static const double SLIVER_DEC=50;
  static double sliverHeight=screenSizeWidth>WEB_MAX_WIDTH?SLIVER_HEIGHT:screenSizeHeight/2.41;
  static double sliverImg=screenSizeWidth>WEB_MAX_WIDTH?SLIVER_IMG:screenSizeHeight/2.81;
  static double sliverDec=screenSizeWidth>WEB_MAX_WIDTH?SLIVER_DEC:screenSizeHeight/16.88;

  static const double ICON_BACK_SIZE=50;
  static double iconBackSize=screenSizeWidth>WEB_MAX_WIDTH?ICON_BACK_SIZE:screenSizeHeight/16.88;

  static const double BORDER_RADIUS_15=15;
  static double borderRadius15=screenSizeWidth>WEB_MAX_WIDTH?BORDER_RADIUS_15:screenSizeHeight/56.27;

  //dynamic buttom buttons
  static const double BUTTOM_BUTTON=120;
  static double buttomButton=screenSizeWidth>WEB_MAX_WIDTH?150:screenSizeHeight/7.03;
  //new hight

}