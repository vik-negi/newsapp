import 'package:flutter/material.dart';
import 'package:news/features/auth/presentation/provider/auth_provider.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/cw_text.dart';
import 'package:news/utils/my_widget.dart';
import 'package:news/utils/widgets/button.dart';
import 'package:news/utils/widgets/cw_formfield.dart';
import 'package:news/utils/widgets/show_snackbar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final authProvider =
          Provider.of<LocalAuthProvider>(context, listen: false);
      String email = _emailController.text.trim();
      String name = _nameController.text.trim();
      String password = _passwordController.text.trim();

      String response = await authProvider.register(email, password, name);

      if (response == "Register Success") {
        showSnackbar(context, response);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        showSnackbar(context, response);
      }
    }
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CWButton(
            ontap: _register,
            width: 231,
            text: "Singup",
            isLoading: _isLoading,
            textColor: R.color.white,
          ),
          vSpacer(9),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, Constants.login);
            },
            child: RichText(
              text: TextSpan(
                text: "Already have an account?",
                style: R.styles.fontPoppins.merge(R.styles.fz16Fw400),
                children: [
                  TextSpan(
                    text: " Login",
                    style:
                        R.styles.fontPoppins.merge(R.styles.fz16Fw700).copyWith(
                              color: R.color.myBlue,
                            ),
                  ),
                ],
              ),
            ),
          ),
          vSpacer(37),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 72, 0, 0),
                  child: CWText(
                    text: "MyNews",
                    color: R.color.myBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                vSpacer(192),
                CWFormField(
                    controller: _nameController,
                    hint: "Name",
                    validator: Constants.nameValidator),
                vSpacer(19),
                CWFormField(
                  controller: _emailController,
                  hint: "Email",
                ),
                vSpacer(19),
                CWFormField(
                  controller: _passwordController,
                  hint: "Password",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
