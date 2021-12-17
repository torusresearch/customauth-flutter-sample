import 'package:customauth_flutter/customauth.dart';
import 'package:flutter/material.dart';

import 'verifiers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomAuth Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CustomAuth Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Verifier? verifier = verifiers[0];
  bool isLoading = true;
  String result = 'Please login to see results.';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      await CustomAuth.init(
          network: TorusNetwork.testnet,
          browserRedirectUri:
              Uri.parse('https://scripts.toruswallet.io/redirect.html'),
          redirectUri: Uri.parse('torus://org.torusresearch.sample/redirect'));
    } catch (err) {
      result = 'Error: ' + err.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> onLoginWithSingleVerifier() async {
    final selectedVerifier = verifier;
    if (selectedVerifier == null || isLoading) return;

    setState(() {
      isLoading = true;
    });
    try {
      final credentials = await CustomAuth.triggerLogin(
          typeOfLogin: selectedVerifier.typeOfLogin,
          verifier: selectedVerifier.verifierId,
          clientId: selectedVerifier.clientId);
      setState(() {
        result = 'Public address: ' + credentials.publicAddress;
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        result = 'Error: ' + err.toString();
        isLoading = false;
      });
    }
  }

  Future<void> onLoginWithAggregatedVerifiers() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });
    try {
      final credentials = await CustomAuth.triggerAggregateLogin(
        aggerateVerifierType: aggregatedVerifier.type,
        verifierIdentifier: aggregatedVerifier.verifierId,
        subVerifierDetailsArray: aggregatedVerifier.subVerifiers,
      );
      setState(() {
        result = 'Public address: ' + credentials.publicAddress;
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        result = 'Error: ' + err.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6),
              child: const Text('Single-verifier Login',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            DropdownButton<Verifier>(
              items: verifiers.map((verifier) {
                return DropdownMenuItem(
                  value: verifier,
                  child: Text(verifier.name),
                );
              }).toList(),
              value: verifier,
              onChanged: (newVerifier) {
                setState(() {
                  verifier = newVerifier;
                });
              },
            ),
            TextButton(
                child: const Text('Login'),
                onPressed: onLoginWithSingleVerifier),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text('Multiple-verifier Login',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            const Text(
                'This example demonstrates aggregate login using only Google. You can use all available login types. See docs.tor.us for details.'),
            TextButton(
                child: const Text('Login'),
                onPressed: onLoginWithAggregatedVerifiers),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text('Native Login',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            const Text(
                'This example demonstrates native Google login using getTorusKey. You can implement any sort of login similarly using either getTorusKey or getAggregateTorusKey. See docs.tor.us for details.'),
            TextButton(
              child: const Text('Login'),
              onPressed: () {},
            ),
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text('Result',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Text(isLoading ? "Loading..." : result),
          ],
        ),
      ),
    );
  }
}
