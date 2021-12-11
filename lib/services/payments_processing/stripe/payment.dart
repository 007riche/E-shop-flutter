import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({
    required this.message,
    required this.success,
  });
}

class StripeService {
  static String apiBase = "https://api.stripe.com/v1";
  static String paymentApiUrl = "${StripeService.apiBase}/payment_intents";

  static Uri paymentApiUri = Uri.parse(paymentApiUrl);

  static String mySecretKey =
      ""; //Put your private stripe key here

  static Map<String, String> headers = {
    "Authorization": "Bearer ${StripeService.mySecretKey}",
    "Content-type": "application/x-www-form-urlencoded",
  };

  static init() { 
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            "", //your public ley
        merchantId: "test", //Here used for in test mode
        androidPayMode: "test",
      ),
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntents(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": amount,
        "currency": currency,
      };

      var response =
          await http.post(paymentApiUri, headers: headers, body: body);

      return jsonDecode(response.body);
    } catch (error) {
      print("Occured error **** ${error.toString()} **** ");
      return {"": 0};
    }
  }

  static Future<StripeTransactionResponse> paymentWithNewCard(
      {String amount = "5", String currency = "USD"}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntents(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent["client_secret"],
          paymentMethodId: paymentMethod.id));

      if (response.status == "succeeded") {
        return StripeTransactionResponse(
            message: "Transaction succesful", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction failed", success: true);
      }
    } on PlatformException catch (error) {
      return getPlatformExceptionErrorResult(error);
    } catch (error) {
      return StripeTransactionResponse(
          message: "Transaction failed: $error ", success: true);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }
    return new StripeTransactionResponse(message: message, success: false);
  }
}
