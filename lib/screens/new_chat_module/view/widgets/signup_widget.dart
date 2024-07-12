// // ignore_for_file: unused_import
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:telekom2/main.dart';

// import '../../constants.dart';
// import '../../service/firebase_firestore_service.dart';
// import '../../service/firebase_storage_service.dart';
// import '../../service/media_service.dart';
// import '../../service/notification_service.dart';

// class SignUpWidget extends StatefulWidget {
// final Function() onClickedSignIn;
// const SignUpWidget({
//   Key? key,
//   required this.onClickedSignIn,
// }) : super(key: key);

//   @override
//   State<SignUpWidget> createState() => _SignUpWidgetState();
// }

// class _SignUpWidgetState extends State<SignUpWidget> {
//   final formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   Uint8List? file;
//   // static final notifications = NotificationsService();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) =>
//       SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 60),
//               GestureDetector(
//                 onTap: () async {
//                   final pickedImage =
//                       await MediaService.pickImage();
//                   setState(() => file = pickedImage!);
//                 },
//                 child: file != null
//                     ? CircleAvatar(
//                         radius: 50,
//                         backgroundImage: MemoryImage(file!),
//                       )
//                     : const CircleAvatar(
//                         radius: 50,
//                         backgroundColor: mainColor,
//                         child: Icon(
//                           Icons.add_a_photo,
//                           size: 50,
//                           color: Colors.white,
//                         ),
//                       ),
//               ),
//               const SizedBox(height: 20),
//               const SizedBox(height: 40),
//               TextFormField(
//                 controller: nameController,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (email) =>
//                     email != null && email.isEmpty
//                         ? 'Name cannot be empty.'
//                         : null,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: emailController,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (email) => email != null &&
//                         !EmailValidator.validate(email)
//                     ? 'Enter a valid email'
//                     : null,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: passwordController,
//                 textInputAction: TextInputAction.next,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (value) =>
//                     value != null && value.length < 6
//                         ? 'Enter min. 6 characters'
//                         : null,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: confirmPasswordController,
//                 textInputAction: TextInputAction.done,
//                 decoration: const InputDecoration(
//                   labelText: 'Confirm Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 obscureText: true,
//                 autovalidateMode:
//                     AutovalidateMode.onUserInteraction,
//                 validator: (value) =>
//                     passwordController.text !=
//                             confirmPasswordController.text
//                         ? 'Passwords do not match'
//                         : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                   icon: const Icon(Icons.arrow_forward,
//                       size: 32),
//                   label: const Text(
//                     'Sign Up',
//                     style: TextStyle(fontSize: 24),
//                   ),
//                   onPressed: signUp),
//               const SizedBox(height: 20),
//               RichText(
//                 text: TextSpan(
//                   style: const TextStyle(
//                       color: Colors.black, fontSize: 20),
//                   text: 'Already have an account?  ',
//                   children: [
//                     TextSpan(
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = widget.onClickedSignIn,
//                       text: 'Log In',
//                       style: TextStyle(
//                         decoration:
//                             TextDecoration.underline,
//                         color: Theme.of(context)
//                             .colorScheme
//                             .secondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );

//   Future signUp() async {
//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;
//     if (file == null) {
//       const snackBar = SnackBar(
//           content: Text('Please select a profile picture'));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) =>
//           const Center(child: CircularProgressIndicator()),
//     );

//     try {
//       final user = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//       final image =
//           await FirebaseStorageService.uploadImage(
//               file!, 'image/profile/${user.user!.uid}');

//       await FirebaseFirestoreService.createUser(
//         image: image,
//         email: user.user!.email!,
//         uid: user.user!.uid,
//         name: nameController.text,
//       );

//       // await notifications.requestPermission();
//       // await notifications.getToken();
//     } on FirebaseAuthException catch (e) {
//       final snackBar = SnackBar(content: Text(e.message!));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//     navigatorKey.currentState!
//         .popUntil(((route) => route.isFirst));
//   }
// }

///new
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:telekom2/screens/homescreeen/HomeScreen.dart';
import 'package:telekom2/screens/new_chat_module/provider/firebase_provider.dart';
import 'package:telekom2/screens/new_chat_module/service/firebase_firestore_service.dart';
import 'package:telekom2/screens/new_chat_module/view/widgets/login_widget.dart';
import 'package:telekom2/utils/ColorPath.dart';
import 'package:telekom2/provider/signup_provider.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
    bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Text(
                  "Sign Up now",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colorpath.cardColor,
                  ),
                ),
                const SizedBox(height: 90),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter username' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: "First Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter first name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: "Last Name",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Enter last name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      !EmailValidator.validate(value!) ? 'Invalid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colorpath.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _usernameController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // API call to register user
    try {
      final apiService = FirebaseProvider(); // Initialize your API service
      final apiResponse = await apiService.registerApi(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      // Check API response and handle accordingly
    
        // Display a progress indicator dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        try {
          // Create user in Firebase Authentication
          final userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          // Create user profile in Firestore
          await FirebaseFirestoreService.createUser(
            // image: image,
            email: userCredential.user!.email!,
            uid: userCredential.user!.uid,
            username: username,
            firstname: firstName,
            lastname: lastName,
            password: password,
            confirmpassword: confirmPassword,
          );

          // Clear form fields
          _usernameController.clear();
          _firstNameController.clear();
          _lastNameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();

          // Close progress indicator dialog
          Navigator.of(context).pop();

          // Navigate to HomeScreen or any other screen upon successful registration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginWidget(onClickedSignUp: toggle,)),
          );
        } on FirebaseAuthException catch (e) {
          // Handle FirebaseAuthException (e.g., invalid email, weak password)
          // Show error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message!),
            ),
          );

          // Close progress indicator dialog
          Navigator.of(context).pop();
        } catch (e) {
          // Handle other exceptions (e.g., network issues, server errors)
          // Show generic error message to the user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registration sucessfully..'),
            ),
          );

          // Close progress indicator dialog
          Navigator.of(context).pop();
        }
     
        // Handle API registration failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('API registration sucessfully. .'),
          ),
        );
      
    } catch (e) {
      // Handle API call exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('API call failed. Please try again.'),
        ),
      );
    }
  }
   void toggle() => setState(() => isLogin = !isLogin);
 
  // Future<void> _signUp() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   final username = _usernameController.text.trim();
  //   final firstName = _firstNameController.text.trim();
  //   final lastName = _lastNameController.text.trim();
  //   final email = _emailController.text.trim();
  //   final password = _passwordController.text.trim();
  //   final confirmPassword = _confirmPasswordController.text.trim();

  //   final provider = Provider.of<FirebaseProvider>(context, listen: false);
  //   await provider.registerApi(
  //     username,
  //      firstName,
  //     lastName,
  //     email,
  //      password,
  //      confirmPassword,
  //   );

  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomeScreen()),
  //   );
  // }
}
