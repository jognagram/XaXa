import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kub_mobile/views/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Bienvenu sur Kub'),
            leading: IconButton(
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout_outlined),
            )),
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Image.asset(
                'assets/logo/Logo_HD-08.png',
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text("Voulez vous louer un véhicule ?")
          ]),
        ));
    //  return Scaffold(
    //      body: SafeArea(
    //    child: Center(
    //      child: Column(
    //        children: [
    //          Center(
    //            child: Text("Bienvenu"),
    //          ),
    //          TextButton(
    //            onPressed: () => _signOut(context),
    //            child: Text("Deconnexion"),
    //          )
    //        ],
    //      ),
    //    ),
    //  ));
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ));
  }
}
