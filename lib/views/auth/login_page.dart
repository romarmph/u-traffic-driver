import 'package:u_traffic_driver/utils/exports/exports.dart';
import 'package:u_traffic_driver/utils/exports/flutter_dart.dart';
import 'package:u_traffic_driver/views/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isObscure = true;
  bool isLoading = false;

  String? _emailError;
  String? _passwordError;

  Future<void> loginBtnPressed() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final authService = AuthService.instance;

      try {
        await authService.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseException catch (e) {
        if (e.code.contains('too-many-requests')) {
          setState(() {
            _emailError = "Too many requests. Try again later";
            _formKey.currentState!.validate();
          });
        }

        if (e.code == "wrong-password") {
          setState(() {
            _passwordError = "Incorrect password";
            _formKey.currentState!.validate();
          });
        }
      } on Exception catch (e) {
        if (e.toString().contains("driver-account-not-found")) {
          setState(() {
            _emailError = "Driver account not found";
            _formKey.currentState!.validate();
          });
        }
      }
    }
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 230,
                color: UColors.blue700,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: USpace.space80),
                    Text(
                      'Sign in to your Account',
                      style: const UTextStyle().text4xlfontmedium.copyWith(
                            color: UColors.white,
                          ),
                    ),
                    Text(
                      'Login to continue',
                      style: const UTextStyle().textbasefontnormal.copyWith(
                            color: UColors.white,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: USpace.space10),
              Padding(
                padding: const EdgeInsets.all(USpace.space12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Email or Phone number',
                      style: const UTextStyle().textsmfontmedium.copyWith(
                            color: UColors.gray900,
                          ),
                    ),
                    const SizedBox(height: USpace.space10),
                    const SizedBox(width: USpace.space4),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Enter your email ',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _emailError = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }

                        return _emailError;
                      },
                    ),
                    Text(
                      'Password',
                      style: const UTextStyle().textsmfontmedium.copyWith(
                            color: UColors.gray900,
                          ),
                    ),
                    const SizedBox(height: USpace.space8),
                    const SizedBox(width: USpace.space10),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: UColors.gray400,
                        ),
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                            color: UColors.gray400,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _passwordError = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }

                        return _passwordError;
                      },
                    ),
                    const SizedBox(height: USpace.space12),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await loginBtnPressed();
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: UColors.white,
                            )
                          : Text(
                              'Login',
                              style: const UTextStyle()
                                  .textbasefontmedium
                                  .copyWith(
                                    color: UColors.white,
                                  ),
                            ),
                    ),
                    const SizedBox(width: USpace.space8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Don't have an account? ",
                            style:
                                const UTextStyle().textbasefontmedium.copyWith(
                                      color: UColors.gray600,
                                    ),
                          ),
                          Text(
                            'Register',
                            style:
                                const UTextStyle().textbasefontmedium.copyWith(
                                      color: UColors.blue700,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
