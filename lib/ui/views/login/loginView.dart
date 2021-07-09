import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hhf_next_gen/app/console_utility.dart';
import 'package:hhf_next_gen/app/providers/authentication_state_notifier.dart';
import 'package:hhf_next_gen/ui/views/home/home_view.dart';
import 'package:hhf_next_gen/ui/views/login/login_form.dart';
import '../../../app/providers/providers.dart';
import '../../../app/routing/routenames.dart' as routes;

class LoginView extends ConsumerWidget {
  LoginView({Key? key}) : super(key: key);
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  bool isBusy = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    final authNotifier = ref.watch(authProvider.notifier);
// authState.
    return Container(
      color: Colors.black.withOpacity(0.65),
      // width: 500,
      // height: 500,
      child: Center(
        child: Container(
          width: 500,
          height: MediaQuery.of(context).size.height * .60,
          child: Card(
            // elevation: 55,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                buildEmailFormField(emailController),
                SizedBox(
                  height: 20,
                ),
                buildPasswordFormField(passwordController),
                SizedBox(
                  height: 20,
                ),
                buildLoginButton(authNotifier),
                SizedBox(
                  height: 10,
                ),
                isBusy ? buildBusy() : Container(),
                buildForgotPassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildForgotPassword() {
    return TextButton.icon(
        onPressed: () {},
        icon: FaIcon(
          FontAwesomeIcons.infoCircle,
          color: Colors.blueGrey.shade400,
          size: 25,
        ),
        label: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.blueGrey.shade300),
        ));
  }

  Container buildLoginButton(AuthStateNotifier authNotifier) {
    return Container(
      // width: 300,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ElevatedButton.icon(
            icon: FaIcon(FontAwesomeIcons.key),
            onPressed: () {
              isBusy = true;
              authNotifier.signIn(
                  email: emailController.text,
                  password: passwordController.text);
              isBusy = false;
            },
            label: Text(
              'Login',
              style: TextStyle(fontSize: 22),
            )),
      ),
    );
  }

  Widget buildBusy() {
    return LinearProgressIndicator();
  }

  Widget buildPasswordFormField(TextEditingController passwordController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        controller: passwordController,
        // keyboardType: TextInputType.emailAddress,
        // onSaved: (newValue) => email = newValue,
        onChanged: (value) {},
        validator: (value) {},
        decoration: InputDecoration(
            labelText: "Password",
            hintText: 'password',
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: FaIcon(FontAwesomeIcons.key)),
      ),
    );
  }

  Widget buildEmailFormField(TextEditingController emailController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        // onSaved: (newValue) => email = newValue,
        onChanged: (value) {},
        validator: (value) {},
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            // If  you are using latest version of flutter then lable text and hint text shown like this
            // if you r using flutter less then 1.20.* then maybe this is not working properly
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: Icon(Icons.email)),
      ),
    );
  }
}