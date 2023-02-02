import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/custom_button.dart';
import 'package:ifood_delivery/base/show_custom_snackbar.dart';
import 'package:ifood_delivery/controllers/search_product_controller.dart';
import 'package:ifood_delivery/pages/search/search_result_widget.dart';
import 'package:ifood_delivery/pages/search/widget/search_field.dart';
import 'package:ifood_delivery/utils/dimensions.dart';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(Get.find<SearchProductController>().isSearchMode) {
          return true;
        }else {
          Get.find<SearchProductController>().setSearchMode(true);
          return false;
        }
      },
      child: Scaffold(
        body: SafeArea(child: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
          child: GetBuilder<SearchProductController>(builder: (searchController) {
            _searchController.text = searchController.searchText;
            return Column(children: [
              Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Row(children: [
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Expanded(child: SearchField(
                  controller: _searchController,
                  hint: 'Nhập nội dung',
                  suffixIcon: !searchController.isSearchMode
                      ? Icons.filter_list : Icons.search,
                  iconPressed: () => _actionSearch(searchController, false),
                  onSubmit: (text) => _actionSearch(searchController, true),
                )),
                CustomButton(
                  onPressed: () => searchController.isSearchMode ? Get.back() : searchController.setSearchMode(true),
                  buttonText: 'Hủy bỏ',
                  transparent: true,
                  width: 80,
                ),
              ]))),
              Expanded(
                  child: searchController.isSearchMode
                  ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Center(child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Tìm kiếm")
                    ]))),
              ) : SearchResultWidget(searchText: _searchController.text.trim())),

            ]);
          }),
        )),
      ),
    );
  }

  void _actionSearch(SearchProductController searchController, bool isSubmit) {
    if(searchController.isSearchMode || isSubmit) {
      if(_searchController.text.trim().isNotEmpty) {
        searchController.searchData(_searchController.text.trim());
      }else {
        showCustomSnackBar('Type is a keyword to search for wine');
      }
    }
  }
}