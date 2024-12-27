import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visible = false;

  @override
  void initState() {
    super.initState();
    emailController.text = "eve.holt@reqres.in";
    passwordController.text = 'cityslicka';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AuthAuthenticated) {
              return Text('Logged in with token: ${state.token}');
            } else if (state is AuthError) {
              return Text(state.message, style: TextStyle(color: Colors.red));
            }
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageLogo(),
                  hbox(15),
                  tffIcon(emailController, 'Email', Icons.email),
                  hbox(10),
                  tffPass(passwordController, 'Password', visible, () {
                    setState(() {
                      visible = !visible;
                    });
                  }),
                  hbox(20),
                  buttonBlue('Login', () {
                    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
