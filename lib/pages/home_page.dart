import 'package:ecp_user/controller/home_controller.dart';
import 'package:ecp_user/pages/login_page.dart';
import 'package:ecp_user/pages/product_description_page.dart';
import 'package:ecp_user/widgets/dropdown_btn.dart';
import 'package:ecp_user/widgets/multi_select_dropdown.dart';
import 'package:ecp_user/widgets/product_card.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Star shop',
              // textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(
                    LoginPage(),
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 51,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ctrl.filterByCategory(
                            ctrl.productCategory[index].name ?? '');
                      },
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Chip(
                          label: Text(
                            ctrl.productCategory[index].name ?? 'Error',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: ctrl.productCategory.length,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropdownBtn(
                      items: ['Rs: Low to High', 'Rs: High to Low'],
                      selectedItemText: 'Sort',
                      onSelected: (selected) {
                        // print(selected);
                        ctrl.sortByPrice(
                            ascending:
                                selected == 'Rs: Low to High' ? true : false);
                      },
                    ),
                  ),
                  Flexible(
                    child: Card(
                      child: MultiSelectDropdown(
                        items: ['tat', 'item2', 'item3'],
                        onSelectionChanged: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8),
                    itemCount: ctrl.productShowUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        imageUrl: ctrl.productShowUi[index].image ?? 'Url',
                        name: ctrl.productShowUi[index].name ?? 'No name',
                        price: ctrl.productShowUi[index].price ?? 00,
                        offerTag: '25 % off',
                        Ontap: () {
                          Get.to(ProductDescriptionPage(),
                              arguments: {'data': ctrl.productShowUi[index]});
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
