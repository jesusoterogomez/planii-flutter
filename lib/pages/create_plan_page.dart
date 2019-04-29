import 'package:flutter/material.dart';
import 'package:planii/bloc/new_plan.dart';

class CreatePlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewPlanProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a new plan'),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: CreatePlanForm(),
        ),
      ),
    );
  }
}

class CreatePlanForm extends StatefulWidget {
  @override
  _CreatePlanFormState createState() => _CreatePlanFormState();
}

class _CreatePlanFormState extends State<CreatePlanForm> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = NewPlanProvider.of(context);
    final double formSpacing = 20;
    final double labelSpacing = formSpacing / 2;
    titleController.text = bloc.plan.value.title;
    locationController.text = bloc.plan.value.location;

    return StreamBuilder(
      stream: bloc.plan,
      initialData: bloc.plan,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Plan data = snapshot.data;

        return ListView(
          children: <Widget>[
            Text(data.toMap().toString()),
            SizedBox(height: formSpacing),
            Text('Start by giving a name to your event'),
            SizedBox(height: labelSpacing),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: bloc.setPlanTitle,
            ),
            SizedBox(height: formSpacing),
            Text('Where is this happening?'),
            SizedBox(height: labelSpacing),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              onChanged: bloc.setPlanLocation,
            ),
            SizedBox(height: formSpacing),
            Text('When are you expecting your guests to arrive?'),
            SizedBox(height: labelSpacing),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              onChanged: bloc.setPlanLocation,
            ),
            SizedBox(height: formSpacing),
            Text('Tell your guests what this is about'),
            SizedBox(height: labelSpacing),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              onChanged: bloc.setPlanLocation,
            ),
          ],
        );
      },
    );
  }
}
