import 'package:flutter/material.dart';
import 'package:planii/bloc/plans.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlansProvider(
      child: new Scaffold(
        appBar: AppBar(
          title: Text('Feed'),
        ),
        body: Container(
          child: FeedItems(),
        ),
      ),
    );
  }
}

class FeedItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PlansProvider.of(context);

    return StreamBuilder(
      stream: bloc.plans,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Container();
        }

        List plans = snapshot.data;

        return ListView.builder(
          // Improve scroll performance in development mode.
          // @see: https://github.com/flutter/flutter/issues/22314#issuecomment-427591926
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: plans.length,
          itemBuilder: (BuildContext context, int index) {
            return FeedItem(plans[index]);
          },
        );
      },
    );
  }
}

class FeedItem extends StatelessWidget {
  final Plan plan;

  // Constructor
  const FeedItem(this.plan);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(plan.coverImage),
              ListTile(
                title: Text(plan.title),
                subtitle: Text(plan.description),
              ),
              ButtonTheme.bar(
                // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('Going'),
                      onPressed: () {/* .. */},
                    ),
                    FlatButton(
                      child: const Text('More...'),
                      onPressed: () {/* .. */},
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
}
