part of 'providers.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  User? get user => _user;

  String? name;
  String? email;
  String? password;
  String? confirmPass;
  int? phnumber;
  bool isLoading = false;

  AuthenticationProvider() {
    _user = _firebaseAuth.currentUser;
  }

  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = _firebaseAuth.currentUser;
      isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } catch (e) {
      isLoading = false;
      String errorMessage = '$e';
      if (e is FirebaseAuthException) {
        errorMessage = e.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      isLoading = true;
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isLoading = false;
      _user = _firebaseAuth.currentUser;
      notifyListeners();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainUi(context: context),
        ),
      );
    } catch (e) {
      // Handle login error
      isLoading = false;
      String errorMessage = '$e';
      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      isLoading = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading = false;
        return;
      }
      isLoading = false;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      isLoading = true;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      isLoading = false;

      // ignore: unused_local_variable
      final User? user = userCredential.user;
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainUi(context: context),
        ),
      );
    } catch (e) {
      isLoading = false;
      const errorMessage = 'Failed to sign in with Google. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      isLoading = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading = false;
        return;
      }
      isLoading = false;
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {}

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainUi(context: context),
        ),
      );
    } catch (e) {
      isLoading = false;
      const errorMessage = 'Failed to sign up with Google. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      isLoading = true;
      await _firebaseAuth.signOut();

      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      isLoading = false;

      _user = null;
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      isLoading = false;
      const errorMessage = 'Failed to sign out. Please try again.';
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }
}
