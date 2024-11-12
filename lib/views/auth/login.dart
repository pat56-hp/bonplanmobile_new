import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/views/auth/widgets/bottomAuthLabel.dart';
import 'package:mobile/views/widgets/buttonWidget.dart';
import 'package:mobile/views/widgets/inputWidget.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';
import 'package:mobile/views/widgets/textWidget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  bool _obscureText = true;
  bool _souvenir = true;

  @override
  void dispose() {
    _userEmailController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: TextWidget(
                    label: 'Connexion',
                    extra: {
                      'color': titleColor,
                      'size': title,
                      'fontWeight': FontWeight.w400
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                  child: TextWidget(
                    label: 'Renseignez vos informations de connexion',
                    extra: {
                      'size': label,
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Obx(() {
                  return InputWidget(
                      controller: _userEmailController,
                      hintText: 'Adresse email',
                      prefixIcon: 'assets/icons/envelope.svg',
                      background: backgroundColorWhite,
                      errorText: _authController.userEmailError.value.isNotEmpty
                          ? _authController.userEmailError.value
                          : null);
                }),
                const SizedBox(
                  height: padding,
                ),
                Stack(
                  children: [
                    Obx(() {
                      return InputWidget(
                        controller: _userPasswordController,
                        hintText: 'Mot de passe',
                        prefixIcon: 'assets/icons/lock.svg',
                        background: backgroundColorWhite,
                        obscureText: _obscureText,
                        errorText:
                            _authController.userPasswordError.value.isNotEmpty
                                ? _authController.userPasswordError.value
                                : null,
                      );
                    }),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Container(
                          color: backgroundColorWhite,
                          child: SvgPicture.asset(
                            _obscureText
                                ? 'assets/icons/eye.svg'
                                : 'assets/icons/low-eye.svg',
                            color: iconColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Switch(
                          value: _souvenir,
                          activeTrackColor: appBarBackground,
                          activeColor: backgroundColorWhite,
                          inactiveThumbColor: appBarBackground,
                          inactiveTrackColor: backgroundColorWhite,
                          trackOutlineColor:
                              MaterialStateProperty.all(galeryIndicator),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onChanged: (bool value) {
                            setState(() {
                              _souvenir = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const TextWidget(
                          label: 'Se souvenir',
                          extra: {'size': label},
                        )
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Get.toNamed('/passwordReset');
                        },
                        child: const TextWidget(
                          label: 'Mot de pase oublié ?',
                          extra: {
                            'size': label,
                            'color': textRed,
                            'textAlign': TextAlign.end
                          },
                        ))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: Obx(
                    () => _authController.loading.value
                        ? const LoadingCircularProgress(
                            color: appBarBackground,
                          )
                        : ButtonWidget(
                            label: 'SE CONNECTER',
                            onPress: () {
                              final userEmail = _userEmailController.text;
                              final userPassword = _userPasswordController.text;
                              _authController.login(
                                  userEmail, userPassword, _souvenir);
                            },
                          ),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 1,
                      color: textColor,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: backgroundColor,
                      child: const TextWidget(label: 'Ou continuer avec'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 48,
                      child: ButtonWidget(
                        label: 'FACEBOOK',
                        labelSize: textSize,
                        backgroundColor: const Color(0xFF3B5998),
                        iconWidget: Row(children: [
                          SvgPicture.asset(
                            'assets/icons/facebook.svg',
                            color: backgroundColorWhite,
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 12,
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 48,
                      child: ButtonWidget(
                        label: 'GOOGLE',
                        labelSize: textSize,
                        backgroundColor: const Color(0xFFDC4E41),
                        iconWidget: Row(children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 12,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
                BottomAuthLabel(
                  labelText: 'Pas encore inscrit ? ',
                  clickLabel: 'Inscrivez-vous',
                  route: () => Get.toNamed('/register'),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
