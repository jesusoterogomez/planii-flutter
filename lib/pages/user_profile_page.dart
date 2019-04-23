import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:planii/bloc/auth.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            UserAvatar(),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.profile,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null || snapshot.data['avatarUrl'] == null) {
          return new Container();
        }

        return new Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 40,
                left: 100,
                right: 100,
                bottom: 20,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepPurple, width: 8.0),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    image: snapshot.data['avatarUrl'],
                  ),
                ),
              ),
            ),
            new Text(
              snapshot.data['displayName'],
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            new Text(
              snapshot.data['email'],
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            new Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: new MaterialButton(
                onPressed: () => bloc.signOut(),
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Log out'),
              ),
            ),
          ],
        );
      },
    );
  }
}
