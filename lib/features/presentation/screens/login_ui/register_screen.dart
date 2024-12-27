import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = "rendy@gmail.com";
    passwordController.text = 'password';
    usernameController.text = 'rendy';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Register')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return CircularProgressIndicator();
          } else if (state is AuthAuthenticated) {
            // return Text('Registered with token: ${state.token}');
            Get.offAll(() => LoginScreen());
          } else if (state is AuthError) {
            return Text(state.message, style: TextStyle(color: Colors.red));
          }
          return Container(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    imageLogo(),
                    hbox(10),
                    tff(usernameController, 'Username'),
                    hbox(10),
                    tff(emailController, 'Email'),
                    hbox(10),
                    tff(passwordController, 'Password'),
                    hbox(20),
                    buttonBlue('Register', () {
                      BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                          email: emailController.text,
                          password: passwordController.text,
                          username: usernameController.text));
                    }),
                    hbox(15),
                    textButton('Sudah punya Akun?', () {
                      Get.offAll(() => LoginScreen());
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
