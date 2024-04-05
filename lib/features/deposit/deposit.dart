import 'package:flutter/material.dart';
import 'package:eth_manager/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:eth_manager/models/transaction_model.dart';
import 'package:eth_manager/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class DepositPage extends StatefulWidget {
  final DashboardBloc dashboardBloc;
  const DepositPage({super.key, required this.dashboardBloc});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController reasonsController = TextEditingController();
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  void dispose() {
    addressController.dispose();
    amountController.dispose();
    reasonsController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Deposit Details",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: SvgPicture.asset(
                "assets/logo_dip.svg",
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: amountController,
              maxLength: 5,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter your Amount',
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            TextField(
              controller: reasonsController,
              maxLength: 50,
              decoration: InputDecoration(
                labelText: 'Reasons',
                hintText: 'Enter your Reasons',
                hintStyle: const TextStyle(color: Colors.grey),
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.green, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SlideAction(
              key: _key,
              sliderRotate: false,
              sliderButtonIcon: const Icon(Icons.add),
              animationDuration: const Duration(milliseconds: 500),
              submittedIcon: const Icon(Icons.check, color: Colors.green),
              borderRadius: 50,
              innerColor: Colors.green,
              outerColor: AppColors.greenAccent,
              elevation: 0,
              onSubmit: () {
                if (amountController.text.isNotEmpty &&
                    reasonsController.text.isNotEmpty) {
                  widget.dashboardBloc.add(
                    DashboardDepositEvent(
                      transactionModel: TransactionModel(
                        addressController.text,
                        int.parse(amountController.text),
                        reasonsController.text,
                        DateTime.now(),
                      ),
                    ),
                  );
                  Future.delayed(
                    const Duration(seconds: 1),
                    () => _key.currentState!.reset(),
                  );
                  Navigator.pop(context);

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text(
                        "please fill all the details",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
              child: const Text(
                "DEPOSIT",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
