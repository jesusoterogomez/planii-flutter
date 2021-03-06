import 'package:flutter/material.dart';
import 'package:planii/bloc/new_plan.dart';
import 'package:planii/widgets/event_dates.dart';

class CreatePlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewPlanProvider(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create a new plan'),
        ),
        body: Container(
          // child: CreatePlanForm(),
          child: CreatePlanContainer(),
        ),
      ),
    );
  }
}

class CreatePlanContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = NewPlanProvider.of(context);

    // Close creation modal when the plan has been fully created
    void handleNavigation(NewPlanStatus status) {
      if (status == NewPlanStatus.created) {
        Navigator.pop(context);
      }
    }

    bloc.status.listen((status) => handleNavigation(status));

    return StreamBuilder(
      stream: bloc.status,
      initialData: bloc.status.value,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        NewPlanStatus status = snapshot.data;

        switch (status) {
          case NewPlanStatus.creating:
            return Text('Creating');
            break;
          case NewPlanStatus.created:
            return Text('Created');
            break;
          default:
            return CreatePlanForm();
        }
      },
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
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = NewPlanProvider.of(context);
    final double formSpacing = 20;
    final double labelSpacing = formSpacing / 2;

    final Plan plan = bloc.plan.value;
    titleController.text = plan.title;
    locationController.text = plan.location;
    descriptionController.text = plan.description;

    return StreamBuilder(
      stream: bloc.plan,
      initialData: bloc.plan.value,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Plan data = snapshot.data;

        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 0,
          ),
          children: <Widget>[
            // Text(data.toMap().toString()),
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
            Text('Date'),
            SizedBox(height: labelSpacing),
            EventDates(
              onStartDateChange: bloc.setPlanStartTime,
            ),
            // Avoid exception when keyboard focuses date-time input
            // @see https://github.com/flutter/flutter/issues/18672
            // SingleChildScrollView(
            //   child: GestureDetector(
            //     onTap: () => selectEventDate(context, bloc.setPlanTime),
            //     child: AbsorbPointer(
            //       child: TextField(
            //         controller: TextEditingController(
            //           text: bloc.plan.value.time.toString(),
            //         ),
            //         decoration: InputDecoration(
            //           labelText: 'Date of the event',
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: formSpacing),
            Text('Tell your guests what this is about'),
            SizedBox(height: labelSpacing),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: bloc.setPlanDescription,
            ),
            SizedBox(height: formSpacing),
            MaterialButton(
              padding: EdgeInsets.all(16),
              onPressed: () => bloc.createPlan(),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Create Plan',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Future selectEventDate(BuildContext context, Function callback) async {
  DateTime eventTime = await showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    initialDate: DateTime.now().add(Duration(hours: 1)),
    lastDate: DateTime.now().add(
      Duration(days: 365 * 2),
    ),
  );

  return callback(eventTime);
}
