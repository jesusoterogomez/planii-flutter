import 'package:flutter/material.dart';
import 'package:planii/bloc/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatelessWidget {
  final Widget logoSVG = new SvgPicture.asset(
    'assets/images/planii-logo.svg',
    semanticsLabel: 'Planii Logo',
    height: 34,
  );

  // final Widget partySVG = new SvgPicture.asset(
  //   'assets/images/party.svg',
  //   semanticsLabel: 'Party',
  // );

  final AssetImage patternBg = new AssetImage("assets/images/pattern.jpg");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      // title: Text('Log in to Planii'),
      // ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: patternBg,
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 80,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              logoSVG,
              // partySVG,
              Expanded(
                flex: 5,
                child: Image(
                  image: AssetImage('assets/images/art-replace-me.png'),
                ),
              ),
              Expanded(
                child: Text(
                  "Start creating plans with your friends, for free!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
              ),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialButton(
            onPressed: () => bloc.signOut(),
            color: Colors.red,
            textColor: Colors.white,
            child: Text('Signout'),
          );
        } else {
          return new GoogleSignInButton(
            onPressed: () => bloc.googleSignIn(),
            darkMode: true, // default: false
          );
        }
      },
    );
  }
}
