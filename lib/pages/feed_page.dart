import 'package:flutter/material.dart';
import 'package:planii/bloc/plans.dart';
import 'package:planii/pages/plan_details_page.dart';

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

    // Fetch data
    bloc.getPlans();

    return StreamBuilder(
      stream: bloc.plans,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          child: new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanDetailsPage(plan: plan),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FeedItemImage(plan.coverImage),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(plan.author.avatarUrl),
                  ),
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
      ),
    );
  }
}

class FeedItemImage extends StatelessWidget {
  final PlanCoverImage image;

  FeedItemImage(this.image);

  @override
  Widget build(BuildContext context) {
    const String placeholder = 'assets/images/event-placeholder-background.jpg';
    if (image.downloadUrl.isEmpty) {
      return Image.asset(placeholder);
    }

    return FadeInImage.assetNetwork(
      fit: BoxFit.fill,
      placeholder: placeholder,
      image: image.downloadUrl,
    );
  }
}
