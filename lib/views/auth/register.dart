import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/views/auth/widgets/BottomAuthLabel.dart';
import 'package:mobile/views/widgets/ButtonWidget.dart';
import 'package:mobile/views/widgets/inputPhoneWidget.dart';
import 'package:mobile/views/widgets/InputWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  FocusNode focusNode = FocusNode();
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool obscureTextPassword = true;
  bool obscureTextPasswordConfirm = true;

  //Validation des champs et soumission de l'inscription
  void _handleSumbit() {
    bool isValidate = true;

    if (_nameController.text == '' ||
        _lastnameController.text == '' ||
        _phoneController.text == '' ||
        _emailController.text == '' ||
        _passwordController.text == '' ||
        _passwordConfirmationController.text == '') {
      showDialogWidget('Inscription !',
          'Veuillez remplir tous les champs pour continuer svp.');
      isValidate = false;
    }

    if (_passwordController.text != _passwordConfirmationController.text) {
      showDialogWidget('Inscription',
          'La confirmation du mot de passe est incorrecte. Veuillez réessayer svp.');
      isValidate = false;
    }

    if (isValidate) {
      _authController.register({
        'name': _nameController.text,
        'lastname': _lastnameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'password_confirmation': _passwordConfirmationController.text,
        'type': 0
      });
    }
  }

  @override
  void dispose(){
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          scrolledUnderElevation: 0,
          leading: Container(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              radius: 24,
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                'assets/icons/icon-left.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
          title: const TextWidget(
            label: 'Inscription',
            extra: {
              'color': titleColor,
              'size': title,
              'fontWeight': FontWeight.w400
            },
          ),
          centerTitle: true,
          //leading: Text('ok')
        ),
        backgroundColor: backgroundColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Center(
                  child: TextWidget(
                    label: 'Inscrivez-vous en renseignant tous les champs',
                    extra: {
                      'size': label,
                    },
                  ),
                ),
                const SizedBox(height: 40),
                InputWidget(
                  controller: _nameController,
                  hintText: 'Nom',
                  prefixIcon: 'assets/icons/user.svg',
                  background: backgroundColorWhite,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  controller: _lastnameController,
                  hintText: 'Prénom(s)',
                  prefixIcon: 'assets/icons/user.svg',
                  background: backgroundColorWhite,
                ),
                const SizedBox(height: 20),
                InputPhoneWidget(
                  controller: _phoneController,
                  focusNode: focusNode,
                ),
                const SizedBox(height: 20),
                InputWidget(
                  controller: _emailController,
                  hintText: 'Adresse email',
                  prefixIcon: 'assets/icons/envelope.svg',
                  background: backgroundColorWhite,
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    InputWidget(
                      controller: _passwordController,
                      hintText: 'Mot de passe',
                      prefixIcon: 'assets/icons/lock.svg',
                      background: backgroundColorWhite,
                      obscureText: obscureTextPassword,
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureTextPassword = !obscureTextPassword;
                          });
                        },
                        child: Container(
                          color: backgroundColorWhite,
                          child: SvgPicture.asset(
                            obscureTextPassword
                                ? 'assets/icons/eye.svg'
                                : 'assets/icons/low-eye.svg',
                            color: iconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    InputWidget(
                      controller: _passwordConfirmationController,
                      hintText: 'Confirmation du mot de passe',
                      prefixIcon: 'assets/icons/lock.svg',
                      background: backgroundColorWhite,
                      obscureText: obscureTextPasswordConfirm,
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureTextPasswordConfirm =
                                !obscureTextPasswordConfirm;
                          });
                        },
                        child: Container(
                          color: backgroundColorWhite,
                          child: SvgPicture.asset(
                            obscureTextPasswordConfirm
                                ? 'assets/icons/eye.svg'
                                : 'assets/icons/low-eye.svg',
                            color: iconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: Obx(
                    () => _authController.loading.value
                        ? const LoadingCircularProgress(
                            color: appBarBackground,
                          )
                        : ButtonWidget(
                            label: 'S\'INSCRIRE',
                            onPress: _handleSumbit,
                          ),
                  ),
                ),
                BottomAuthLabel(
                  labelText: 'Déjà un compte ? ',
                  clickLabel: 'Se connecter',
                  route: () => Get.toNamed('/login'),
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
        ));
  }
}
