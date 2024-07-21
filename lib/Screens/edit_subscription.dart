import 'package:flutter/material.dart';
import 'package:spendwise/Models/subscription.dart';

class EditSubscription extends StatefulWidget {
  const EditSubscription({super.key, required this.subscription});

  final Subscription subscription;

  @override
  State<EditSubscription> createState() => _EditSubscriptionState();
}

class _EditSubscriptionState extends State<EditSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Subscription : ${widget.subscription.name}"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(widget.subscription.name),
      ),
    );
  }
}
