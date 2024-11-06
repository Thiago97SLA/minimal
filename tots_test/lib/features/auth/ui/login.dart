import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/button/border_button.dart';
import 'package:tots_test/components/scaffold/custom_scaffold.dart';
import 'package:tots_test/components/textfromfield/custom_text_from_field.dart';
import 'package:tots_test/constant/imagen.dart';
import 'package:tots_test/features/auth/provider/auth_provider.dart';
import 'package:tots_test/utils/custom_font_style.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      imgBackground: Imagen.backgroundImg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Imagen.iconAppImg,
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          const SizedBox(height: 30),
          Text(
            'LOG  IN',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 50),
          CustomTextFormField(
            hintText: 'Mail',
            controller: controllerUser,
          ),
          CustomTextFormField(
            isPassword: true,
            hintText: 'Password',
            controller: controllerPassword,
          ),
          const SizedBox(height: 30),
          BorderButton(
            title: Text(
              'LOG  IN',
              style: FontConstants.heading3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () {
              ref.read(authProvider.notifier).login(
                  email: controllerUser.text,
                  password: controllerPassword.text);
            },
          )
        ],
      ),
    );
  }
}
