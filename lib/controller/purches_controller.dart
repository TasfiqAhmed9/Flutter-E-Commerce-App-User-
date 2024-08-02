import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class PurchesController extends GetxController {
  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';
  submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;

    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
          store_id: 'c6692b1d70df0d',
          store_passwd: 'c6692b1d70df0d@ssl',
          total_amount: price,
          currency: SSLCurrencyType.BDT,
          tran_id: '12345',
          product_category: item,
          sdkType: SSLCSdkType.TESTBOX),
    );
    
    sslcommerz.payNow();
    // Sslcommerz sslcommerz = Sslcommerz(
    //     initializer: SSLCommerzInitialization(
    //         store_id: 'c6692b1d70df0d',
    //         store_passwd: '',
    //         total_amount: price,
    //         currency: SSLCurrencyType.BDT,
    //         tran_id: tran_id,
    //         product_category: item,
    //         sdkType: sdkType));
  }
  
}
