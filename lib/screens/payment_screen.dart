import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // Import for PIN code input

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController upiIdController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  @override
  void dispose() {
    upiIdController.dispose();
    amountController.dispose();
    pinController.dispose();
    super.dispose();
  }

  void processPayment() {
    // Implement payment processing logic here
    // For demonstration, show a toast message
    Fluttertoast.showToast(
      msg: 'Payment processed successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPI Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter UPI ID and Amount',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: upiIdController,
              decoration: const InputDecoration(
                labelText: 'UPI ID',
                hintText: 'example@upi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₹',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Enter UPI PIN to Confirm Payment',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            PinCodeTextField(
              controller: pinController,
              appContext: context,
              length: 4,
              obscureText: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              onChanged: (value) {
                // Handle PIN input change
              },
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: processPayment,
                child: const Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
