import 'package:customauth_flutter/customauth.dart';

class Verifier {
  final TorusLogin typeOfLogin;
  final String name;
  final String verifierId;
  final String clientId;
  final String? domain;
  final String? verifierIdField;
  final bool isVerifierIdCaseSensitive;

  Verifier(
      {required this.typeOfLogin,
      required this.name,
      required this.verifierId,
      required this.clientId,
      this.domain,
      this.verifierIdField,
      this.isVerifierIdCaseSensitive = false});
}

final verifiers = <Verifier>[
  Verifier(
      typeOfLogin: TorusLogin.google,
      name: "Google",
      verifierId: "google-lrc",
      clientId:
          "221898609709-obfn3p63741l5333093430j3qeiinaa8.apps.googleusercontent.com"),
  Verifier(
      typeOfLogin: TorusLogin.facebook,
      name: "Facebook",
      verifierId: "facebook-lrc",
      clientId: "617201755556395"),
  Verifier(
      typeOfLogin: TorusLogin.twitch,
      name: "Twitch",
      verifierId: "twitch-lrc",
      clientId: "f5and8beke76mzutmics0zu4gw10dj"),
  Verifier(
      typeOfLogin: TorusLogin.discord,
      name: "Discord",
      verifierId: "discord-lrc",
      clientId: "682533837464666198"),
];

class AggregatedVerifier {
  final TorusAggregateVerifierType type;
  final String verifierId;
  final List<TorusSubVerifierDetails> subVerifiers;

  AggregatedVerifier(
      {required this.type,
      required this.verifierId,
      required this.subVerifiers});
}

final aggregatedVerifier = AggregatedVerifier(
    type: TorusAggregateVerifierType.single_id_verifier,
    verifierId: "chai-google-aggregate-test",
    subVerifiers: [
      TorusSubVerifierDetails(
          typeOfLogin: TorusLogin.google,
          verifier: 'google-chai',
          clientId:
              '884454361223-nnlp6vtt0me9jdsm2ptg4d1dh8i0tu74.apps.googleusercontent.com')
    ]);
