import 'package:flutter/material.dart';
import '../auth/auth_page.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/snackbar.dart';
import 'login_page.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });

    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.8,
                child: Image.asset('assets/logo/Logo_HD-08.png'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Créez votre profile",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              TextFieldInput(
                  icon: Icons.person,
                  textEditingController: nameController,
                  hintText: 'Votre nom',
                  textInputType: TextInputType.text),
              TextFieldInput(
                  icon: Icons.email,
                  textEditingController: emailController,
                  hintText: 'Votre mail',
                  textInputType: TextInputType.text),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Votre mot de passe',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              MyButtons(onTap: signupUser, text: "Inscription"),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Avez vous déjà un compte?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Connectez vous",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
