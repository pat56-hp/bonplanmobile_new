import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/views/widgets/TextWidget.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<String> _onboardinDescs = [
    "1 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis faucibus mi eu ultrices",
    "2 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis faucibus mi eu ultrices",
    "3 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sagittis faucibus mi eu ultrices",
  ];

  int _current = 0;

  String labelButtonLeft = "Passer";
  String labelButtonRight = "Suivant";

  void handleTapButtonLeft() {
    setState(() {
      if (_current == 0) {
        Get.offNamed("/login");
      } else {
        _current--;
        labelButtonLeft = _current == 0 ? "Passer" : "Précédent";
        labelButtonRight = "Suivant";
      }
    });
  }

  void handleTapButtonRight() {
    setState(() {
      if (_current < 2) {
        _current++;
        labelButtonRight = _current == 2 ? "Terminer" : "Suivant";
        labelButtonLeft = "Précédent";
      } else {
        Get.offNamed("/login");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Center(
                child: SizedBox(
                    width: 200,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Image.asset('assets/images/onboarding-img.png',
                    fit: BoxFit.cover),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: appBarBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const TextWidget(
                    label: 'Lorem ipsum dolor sit amet',
                    extra: {
                      'color': textWhite,
                      'size': 28.0,
                      'fontWeight': FontWeight.w500
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                    label: _onboardinDescs[_current],
                    extra: const {
                      'size': subtitle,
                      'color': Colors.white70,
                      'fontWeight': FontWeight.w500,
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: handleTapButtonLeft,
                        child: TextWidget(
                          label: labelButtonLeft,
                          extra: const {
                            'color': textWhite,
                            'fontWeight': FontWeight.w500,
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _onboardinDescs.asMap().entries.map((entry) {
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? backgroundColorWhite
                                  : const Color(0xFFEE9EAB),
                            ),
                          );
                        }).toList(),
                      ),
                      InkWell(
                        onTap: handleTapButtonRight,
                        child: TextWidget(
                          label: labelButtonRight,
                          extra: const {
                            'color': textWhite,
                            'fontWeight': FontWeight.w500,
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
