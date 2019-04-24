import 'package:flutter/material.dart';
import 'package:planii/bloc/plan_details.dart';

class PlanDetailsPage extends StatelessWidget {
  final Plan plan;

  PlanDetailsPage({this.plan});

  @override
  Widget build(BuildContext context) {
    return PlanDetailsProvider(
      planId: plan.id,
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Plan Details'),
        ),
        body: PlanDetailsBody(plan),
      ),
    );
  }
}

class PlanDetailsBody extends StatelessWidget {
  final Plan cachedPlan;

  PlanDetailsBody(this.cachedPlan);

  @override
  Widget build(BuildContext context) {
    final bloc = PlanDetailsProvider.of(context);

    return StreamBuilder(
      stream: bloc.plan,
      initialData: cachedPlan,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Plan plan = snapshot.data;

        return Text('Title: ${plan.title}');
      },
    );
  }
}
