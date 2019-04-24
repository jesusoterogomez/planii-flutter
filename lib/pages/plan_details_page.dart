import 'package:flutter/material.dart';
import 'package:planii/bloc/plans.dart';

class PlanDetailsPage extends StatelessWidget {
  final Plan plan;

  PlanDetailsPage({this.plan});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Plan Details ${plan.title}'),
      ),
      body: Container(
        child: Text('Some details'),
      ),
    );
  }
}
