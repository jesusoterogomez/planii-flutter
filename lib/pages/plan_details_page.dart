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

        return Column(
          children: <Widget>[
            PlanDetailsHeader(plan),
            PlanDetailsDescription(plan.description),
            PlanGuests(),
            // PlanDetailsPeople(plan.),
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
    double headerHeight = MediaQuery.of(context).size.height * 0.4;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          height: headerHeight,
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
          height: headerHeight,
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
                      plan.location,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 16.0,
          top: 50.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class PlanDateBox extends StatelessWidget {
  final DateTime time;

  PlanDateBox(this.time);

  @override
  Widget build(BuildContext context) {
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
          // Container(child: ,)
        ],
      ),
    );
  }
}

class PlanGuests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = GuestsProvider.of(context);

    return StreamBuilder(
      stream: bloc.guests,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Guests guests = snapshot.data;

        return Column(
            // children:
            );
        // print(
        // '--- list received ${guestList['Kf82xvKRVkXVdOTjK92BeJtb3gj1'].answer}');

        // return ListView.builder(
        //   // Improve scroll performance in development mode.
        //   // @see: https://github.com/flutter/flutter/issues/22314#issuecomment-427591926
        //   physics: AlwaysScrollableScrollPhysics(),
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   itemCount: guests.list.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     Guest guest = guests.list[index];

        //     return Text('${guest.displayName} ${guest.answer}');
        //     // return FeedItem(plans[index]);
        //   },
        // );

        // return Column(
        //   children: <Widget>[
        //     guests.map(new Text('Test'));
        //     // PlanDetailsHeader(plan),
        //     // PlanDetailsDescription(plan.description),
        //     // PlanDetailsPeople(plan.),
        //   ],
        // );
      },
    );
  }
}
