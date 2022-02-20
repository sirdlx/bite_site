import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:losbetosapp/main.dart';
import 'package:losbetosapp/src/components/card.dart';
import 'package:losbetosapp/src/features/account/account_view.dart';
import 'package:losbetosapp/src/features/auth/auth_controller.dart';
import 'package:losbetosapp/src/features/cart/cart_controller.dart';
import 'package:losbetosapp/src/features/menu_item/menu_item_view.dart';
import 'package:losbetosapp/src/utilities/utilities.dart';
import 'package:stripe/stripe.dart';

// ignore: unused_import
import 'package:flavor_ui/flavor_ui.dart' as fui;
import 'package:credit_card_validator/credit_card_validator.dart';

final stripe = Stripe('pk_live_USmHX5TrK8I3SvBmC2Vvxnr4');

const String stripeKey = 'sk_live_CoUll840EGxpyIuIKoF6FZwt';

class ScreenCheckout extends StatelessWidget {
  const ScreenCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var checkout = appController.cart;

    return Consumer(
      builder: (context, ref, child) {
        LBAuthNotifier auth = ref.watch(authControllerProvider);
        print('auth.user?.isAnonymous::${auth.user?.isAnonymous}');
        if (auth.user != null && !auth.user!.isAnonymous!) {
          return ScreenCheckoutAuth(auth: auth, cart: checkout);
        } else {
          return ScreenAccountPicker(auth: auth);
        }
      },
    );
  }
}

class ScreenCheckoutAuth extends StatelessWidget {
  final LBAuthNotifier auth;

  final CartController cart;

  const ScreenCheckoutAuth({
    Key? key,
    required this.auth,
    required this.cart,
  }) : super(key: key);
  CollectionReference get allCustomersRef =>
      FirebaseFirestore.instance.collection('/customers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      bottomNavigationBar: OrderButton(
        onTap: () {
          final snackBar = SnackBar(
            content: const Text('Placing Order... Please wait'),
            duration: const Duration(milliseconds: 10000),
            action: SnackBarAction(
              label: 'Cancel',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        text: "Place Order",
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
            future: allCustomersRef
                .where('email', isEqualTo: auth.user!.email)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map map = snapshot.data!.docs[0].data()! as Map;
                print('map::${map}');

                String stripeId = map['stripeId'];

                return Center(
                  child: SizedBox(
                    width: 320,
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LBCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text('Subtotal'),
                                  trailing: Text(toPricingText(cart.total)),
                                ),
                                ListTile(
                                  title: Text('Tax'),
                                  trailing: Text('\$5.80'),
                                ),
                                ListTile(
                                  title: Text('Total'),
                                  trailing: Text('\$5.80'),
                                ),
                              ],
                            ),
                          ),
                          LBCard(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text('Payment Method'),
                                ),
                                FutureBuilder(
                                  future: fetchJson(
                                    'https://api.stripe.com/v1/customers/$stripeId/payment_methods?&type=card',
                                    headers: {
                                      "Authorization": "Bearer $stripeKey"
                                    },
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      var dataJson = snapshot.data as Map;
                                      List items = dataJson['data'];

                                      if (items.length == 0) {
                                        return ListTile(
                                          tileColor:
                                              Theme.of(context).primaryColor,
                                          title: Text('Add'),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ScreenAddPayment();
                                              },
                                            );
                                          },
                                        );
                                      } else {
                                        return RadioListTile(
                                          value: true,
                                          groupValue: true,
                                          onChanged: (value) {},
                                        );
                                      }
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

class ScreenAddPayment extends StatefulWidget {
  const ScreenAddPayment({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenAddPayment> createState() => _ScreenAddPaymentState();
}

class _ScreenAddPaymentState extends State<ScreenAddPayment> {
  late StripeCard newCard;

  // ignore: prefer_final_fields
  bool _busy = false;

  final CreditCardValidator _ccValidator = CreditCardValidator();

  @override
  void initState() {
    newCard = StripeCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Payment'),
      ),
      body: Center(
        child: SizedBox(
          width: 320,
          child: Form(
            onChanged: () {
              print('changed');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 16,
                  enabled: !_busy,
                  decoration: const InputDecoration(labelText: 'Card Number'),
                  initialValue: '4242424242424242',
                  validator: (input) {
                    var ccNumResults = _ccValidator.validateCCNum(input ?? '');
                    print(ccNumResults.isValid);
                    return ccNumResults.isValid
                        ? null
                        : 'Please enter card number';
                  },
                  onSaved: (newValue) => setState(() {
                    newCard.number = newValue;
                  }),
                  onChanged: (input) => setState(() {
                    newCard.number = input;
                  }),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: true,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        maxLength: 2,
                        enabled: !_busy,
                        decoration: const InputDecoration(
                            labelText: 'Experation Month (MM)'),
                        initialValue: '0122',
                        validator: (input) {
                          var ccNumResults =
                              _ccValidator.validateCCNum(input ?? '');
                          print(ccNumResults.isValid);
                          return ccNumResults.isValid
                              ? null
                              : 'Please enter card experation month';
                        },
                        onSaved: (newValue) => setState(() {
                          newCard.exp_month = int.parse(newValue!);
                        }),
                        onChanged: (input) => setState(() {
                          newCard.exp_month = int.parse(input);
                        }),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofocus: true,
                      ),
                    ),
                    Spacer(),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        maxLength: 3,
                        enabled: !_busy,
                        decoration: const InputDecoration(
                            labelText: 'CVC (code on back)'),
                        initialValue: '22',
                        validator: (input) {
                          var ccNumResults =
                              _ccValidator.validateExpDate(input ?? '');
                          print(ccNumResults.isValid);
                          return ccNumResults.isValid
                              ? null
                              : 'Please enter card CVC number';
                        },
                        onSaved: (newValue) => setState(() {
                          newCard.exp_year = int.parse(newValue!);
                        }),
                        onChanged: (input) => setState(() {
                          newCard.exp_year = int.parse(input);
                        }),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autofocus: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      print(newCard.toJson());
                    },
                    child: Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StripeCard {
  String? number;
  // ignore: non_constant_identifier_names
  int? exp_month;
  // ignore: non_constant_identifier_names
  int? exp_year;
  String? cvc;
  StripeCard({
    this.number,
    // ignore: non_constant_identifier_names
    this.exp_month,
    // ignore: non_constant_identifier_names
    this.exp_year,
    this.cvc,
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'exp_month': exp_month,
      'exp_year': exp_year,
      'cvc': cvc,
    };
  }

  factory StripeCard.fromMap(Map<String, dynamic> map) {
    return StripeCard(
      number: map['number'],
      exp_month: map['exp_month'],
      exp_year: map['exp_year'],
      cvc: map['cvc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeCard.fromJson(String source) =>
      StripeCard.fromMap(json.decode(source));
}

class StripeBillingDetails {
  String city;
  String country;
  String line1;
  String line2;
  // ignore: non_constant_identifier_names
  String postal_code;
  String state;

  String name;
  StripeBillingDetails({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    // ignore: non_constant_identifier_names
    required this.postal_code,
    required this.state,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'country': country,
      'line1': line1,
      'line2': line2,
      'postal_code': postal_code,
      'state': state,
      'name': name,
    };
  }

  factory StripeBillingDetails.fromMap(Map<String, dynamic> map) {
    return StripeBillingDetails(
      city: map['city'],
      country: map['country'],
      line1: map['line1'],
      line2: map['line2'],
      postal_code: map['postal_code'],
      state: map['state'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StripeBillingDetails.fromJson(String source) =>
      StripeBillingDetails.fromMap(json.decode(source));
}
