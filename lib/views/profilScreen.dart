import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/constants/color.dart';
import 'package:mobile/constants/size.dart';
import 'package:mobile/controllers/authController.dart';
import 'package:mobile/utils/helper.dart';
import 'package:mobile/views/widgets/ButtonWidget.dart';
import 'package:mobile/views/widgets/IconButtonWidget.dart';
import 'package:mobile/views/widgets/Info.dart';
import 'package:mobile/views/widgets/inputPhoneWidget.dart';
import 'package:mobile/views/widgets/InputWidget.dart';
import 'package:mobile/views/widgets/TextWidget.dart';
import 'package:mobile/views/widgets/userImage.dart';
import 'package:mobile/views/widgets/loadingCircularProgress.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = _authController.user.value!.name;
    _lastnameController.text = _authController.user.value!.lastname;
    _phoneController.text = _authController.user.value!.phone;
    _adresseController.text = _authController.user.value!.adresse!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _phoneController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Soumission du formulaire pour la modification du profil
    void handleSubmit() async {
      final bool response = await _authController.updateProfile({
        'name': _nameController.text,
        'lastname': _lastnameController.text,
        'phone': _phoneController.text,
        'adresse': _adresseController.text
      });

      if (response) {
        Get.back();
        showSnackBarWidget(
          type: 'success',
          content: 'Votre profil a été modifié avec succès !',
        );
      }
    }

    void showBottomSheetImage() {
      showModalBottomSheet(
          isScrollControlled: false,
          context: context,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.2,
          ),
          builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Container(
                    decoration: const BoxDecoration(
                        color: backgroundColorWhite,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Column(
                      children: [
                        Container(
                          height: 4,
                          width: 70,
                          color: profilBorder,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 48,
                          child: ButtonWidget(
                            onPress: () => _authController.pickImage(ImageSource.camera),
                            label: 'Prendre une photo',
                            labelSize: textSize,
                            iconWidget: Row(children: [
                              SvgPicture.asset(
                                'assets/icons/camera.svg',
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
                          height: 10,
                        ),
                        SizedBox(
                          height: 48,
                          child: ButtonWidget(
                            onPress: () => _authController.pickImage(ImageSource.gallery),
                            label: 'Choisir une image',
                            labelSize: textSize,
                            iconWidget: Row(children: [
                              SvgPicture.asset(
                                'assets/icons/capture.svg',
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
                      ],
                    )),
              ));
    }

    void showBottomSheet() => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                  decoration: const BoxDecoration(
                      color: backgroundColorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              height: 4,
                              width: 70,
                              color: profilBorder,
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            const TextWidget(
                              label: 'Modifier mes informations personnelles',
                              extra: {'size': label},
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            InputWidget(
                              controller: _nameController,
                              hintText: 'Nom',
                              prefixIcon: 'assets/icons/user.svg',
                              background: backgroundColorWhite,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputWidget(
                              controller: _lastnameController,
                              hintText: 'Prénom(s)',
                              prefixIcon: 'assets/icons/user.svg',
                              background: backgroundColorWhite,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputPhoneWidget(
                                controller: _phoneController,
                                focusNode: focusNode),
                            const SizedBox(
                              height: 15,
                            ),
                            InputWidget(
                              controller: _adresseController,
                              hintText: 'Localisation',
                              prefixIcon: 'assets/icons/marker.svg',
                              background: backgroundColorWhite,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: Obx(() => _authController.loading.value
                            ? const LoadingCircularProgress(
                                color: appBarBackground)
                            : ButtonWidget(
                                label: 'ENREGISTRER',
                                onPress: handleSubmit,
                              )),
                      )
                    ],
                  )),
            ),
          ),
        );

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          leading: Navigator.canPop(context)
              ? Container(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    radius: 24,
                    onTap: () => Get.back(),
                    child: SvgPicture.asset(
                      'assets/icons/icon-left.svg',
                      width: 22,
                      height: 22,
                    ),
                  ),
                )
              : null,
          title: const TextWidget(
            label: 'Mon profil',
            extra: {'color': Colors.black, 'size': title},
          ),
        ),
        backgroundColor: backgroundColor,
        body: Center(
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Obx(() {
                        return UserImage(
                          height: 120,
                          width: 120,
                          borderRadius: 60,
                          borderColor: appBarBackground,
                          image: _authController.user.value?.image,
                        );
                      }),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButtonWidget(
                              backgroundColor: Color.fromARGB(89, 224, 79, 103),
                              icon: 'assets/icons/capture.svg',
                              padding: 0,
                              sizeIcon: 18,
                              pressFunction: showBottomSheetImage),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const TextWidget(
                            label: 'Informations personnelles',
                            extra: {'size': label},
                          ),
                          SizedBox(
                            width: 38,
                            height: 38,
                            child: IconButtonWidget(
                              backgroundColor:
                                  const Color.fromARGB(25, 224, 79, 103),
                              icon: 'assets/icons/user-update.svg',
                              padding: 0,
                              colorIcon: appBarBackground,
                              sizeIcon: 20,
                              pressFunction: showBottomSheet,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: backgroundColorWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(31, 0, 0, 0),
                                  offset: Offset(1, 1),
                                  blurRadius: 5)
                            ]),
                        child: Obx(() => _authController.loading.value
                            ? const LoadingCircularProgress(
                                color: appBarBackground,
                              )
                            : Column(
                                children: [
                                  Info(
                                    icon: 'assets/icons/user.svg',
                                    label: 'Nom',
                                    labelValue:
                                        _authController.user.value?.name ?? '',
                                    border: true,
                                  ),
                                  Info(
                                      icon: 'assets/icons/user.svg',
                                      label: 'Prénom(s)',
                                      labelValue: _authController
                                              .user.value?.lastname ??
                                          '',
                                      border: true),
                                  Info(
                                      icon: 'assets/icons/phone.svg',
                                      label: 'Contact',
                                      labelValue:
                                          '+${_authController.user.value?.phone ?? ''}',
                                      border: true),
                                  Info(
                                      icon: 'assets/icons/envelope.svg',
                                      label: 'Email',
                                      labelValue:
                                          _authController.user.value?.email ??
                                              '',
                                      border: true),
                                  Info(
                                    icon: 'assets/icons/marker.svg',
                                    label: 'Adresse',
                                    labelValue:
                                        _authController.user.value?.adresse ??
                                            'Aucune adresse',
                                  ),
                                ],
                              )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
