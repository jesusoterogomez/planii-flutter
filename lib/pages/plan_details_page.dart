import 'package:flutter/material.dart';
import 'package:planii/bloc/plan_details.dart';
import 'package:planii/bloc/guests.dart';
import 'package:planii/bloc/analytics.dart';
import 'package:intl/intl.dart';

class PlanDetailsPage extends StatelessWidget {
  final Plan plan;

  PlanDetailsPage({this.plan});

  @override
  Widget build(BuildContext context) {
    final bloc = AnalyticsProvider.of(context);

    bloc.analytics.logEvent(
      name: 'view_plan_details',
    );

    return PlanDetailsProvider(
      planId: plan.id,
      child: GuestsProvider(
        planId: plan.id,
        child: new Scaffold(
          body: PlanDetailsBody(plan),
        ),
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
        double headerHeight = MediaQuery.of(context).size.height * 0.4;

        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // title: Text('SliverAppBar'),
              backgroundColor: Colors.transparent,
              expandedHeight: headerHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: PlanDetailsHeader(plan),
                // background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  PlanDetailsDescription(plan.description),
                  AttendanceButtons(),
                  PlanGuestList(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class PlanDetailsHeader extends StatelessWidget {
  final Plan plan;

  PlanDetailsHeader(this.plan);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: plan.coverImage.downloadUrl.isNotEmpty
                  ? new NetworkImage(plan.coverImage.downloadUrl)
                  : new AssetImage(
                      'assets/images/event-placeholder-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          // height: headerHeight,
          padding: EdgeInsets.all(30.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 0.6)),
          alignment: Alignment.bottomCenter,
          child: new Column(
            // Snap items to bottom of column/container
            // @see: https://stackoverflow.com/a/45777468/781779
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: PlanDateBox(plan.time),
              ),
              SizedBox(height: 10.0),
              Text(
                plan.title,
                style: TextStyle(
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      plan.location ?? 'To be defined',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PlanDateBox extends StatelessWidget {
  final DateTime time;

  PlanDateBox(this.time);

  @override
  Widget build(BuildContext context) {
    if (time == null) {
      return new Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.date_range,
                size: 18,
              ),
              SizedBox(width: 5.0),
              Text(
                'To be defined',
                style: TextStyle(
                    // fontSize: 22,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    // Date Formatting
    // @see https://docs.flutter.io/flutter/intl/DateFormat-class.html
    String weekday = (new DateFormat.E().format(time));
    String day = (new DateFormat.d().format(time));
    String month = (new DateFormat.MMM().format(time));

    return new Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              weekday.toUpperCase(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              day,
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
              ),
            ),
            Text(
              month.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanDetailsDescription extends StatelessWidget {
  final String description;

  PlanDetailsDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(description),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(description),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(description),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PlanGuestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GuestsProvider.of(context);

    return StreamBuilder(
      stream: bloc.guests,
      initialData: Guests.empty(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Guests guests = snapshot.data;

        if (guests.list.length == 0) {
          return Container();
        }

        List<Widget> guestRows =
            guests.list.map((Guest guest) => renderGuestRow(guest)).toList();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'People',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: guestRows,
              )
            ],
          ),
        );
      },
    );
  }
}

Widget renderGuestRow(Guest guest) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(guest.avatarUrl),
    ),
    title: Text(guest.displayName),
    subtitle: Text(guest.answer),
  );
}

class AttendanceButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GuestsProvider.of(context);

    return StreamBuilder(
      stream: bloc.currentUserResponse,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String answer = snapshot.data;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Are you going?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  ResponseButton(
                    response: 'yes',
                    icon: Icons.check_circle_outline,
                    currentAnswer: answer,
                  ),
                  ResponseButton(
                    response: 'no',
                    icon: Icons.close,
                    currentAnswer: answer,
                  ),
                  ResponseButton(
                    response: 'maybe',
                    icon: Icons.help_outline,
                    currentAnswer: answer,
                  ),
                ],
              ),
              answer != null
                  ? Text('You answered: $answer')
                  : Text("You still haven't responded")
            ],
          ),
        );
      },
    );
  }
}

class ResponseButton extends StatelessWidget {
  final String response;
  final IconData icon;
  final String currentAnswer;

  ResponseButton({this.response, this.icon, this.currentAnswer});

  @override
  Widget build(BuildContext context) {
    final bloc = GuestsProvider.of(context);

    final double iconSize = 20;
    final double buttonHeight = 36;
    final double borderWidth = 2.0;
    final Color primaryColor = Theme.of(context).primaryColor;

    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    final String labelText = capitalize(response);

    if (response == currentAnswer) {
      return ButtonTheme(
        height: buttonHeight + borderWidth,
        child: FlatButton.icon(
          icon: Icon(
            icon,
            size: iconSize,
          ),
          color: primaryColor,
          textColor: Colors.white,
          onPressed: () => ({}),
          label: Text(labelText),
        ),
      );
    }
    return ButtonTheme(
      height: buttonHeight,
      child: OutlineButton.icon(
        icon: Icon(
          icon,
          size: iconSize,
        ),
        borderSide: BorderSide(
          color: primaryColor,
          width: borderWidth,
        ),
        textColor: primaryColor,
        label: Text(labelText),
        onPressed: () => bloc.saveCurrentUserResponse(response),
      ),
    );
  }
}
