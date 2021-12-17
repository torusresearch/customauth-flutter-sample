# CustomAuth Flutter Samples

Examples of using [Torus CustomAuth Flutter SDK].

**Usage**

1. Clone the repository and open with Android Studio/Visual Studio Code

2. Run the app, you'll see a demo app demonstrating full functionalities
   of [Torus CustomAuth Flutter SDK]

- OAuth/Social logins

- Aggregate logins returning same keys for different providers

- Native/custom logins using `getTorusKey` and `getAggregateTorusKey`

3. All configurations are written to `lib/verifiers.dart`, update the values accordingly to try
   with your specific configurations.

**Caveat**

Native Google Sign-In sometimes return the same ID token even if we already
called [`revokeAccess` and `signOut`](https://developers.google.com/identity/sign-in/android/disconnect),
Torus Nodes will always reject token previously used to authenticate to avoid one node can
reconstruct the user's key.

To make sure that Google Sign-In always succeed, makes sure to store the user's key in
secure local storage and only call `getTorusKey` if native Google Sign-In returns a different token.

<!-- Links -->

[torus customauth flutter sdk]: https://github.com/torusresearch/customauth-flutter-sdk