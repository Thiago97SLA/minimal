import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_test/components/button/border_button.dart';
import 'package:tots_test/components/textfromfield/custom_text_from_field.dart';
import 'package:tots_test/constant/imagen.dart';
import 'package:tots_test/core/state/appstate.dart';
import 'package:tots_test/features/home/model/clients_model.dart';
import 'package:tots_test/features/home/provider/home_provider.dart';
import 'package:tots_test/utils/custom_font_style.dart';
import 'package:tots_test/utils/palette.dart';

final customModalsProvider = Provider<CustomModals>(CustomModalsImpl.fromRead);

abstract class CustomModals {
  Future<void> showLoadingDialog([BuildContext? context]);

  void pop();

  void removeDialog([BuildContext? context]);

  Future<void> showEditClient({
    BuildContext? context,
    required ClientModel client,
    required WidgetRef ref,
  });

  Future<void> showAddClient({
    BuildContext? context,
    required WidgetRef ref,
  });

  Future<void> showErrorDialog([BuildContext? context]);
  Future<void> showSuccesDialog([BuildContext? context]);
}

class CustomModalsImpl implements CustomModals {
  CustomModalsImpl({required this.appState});

  factory CustomModalsImpl.fromRead(Ref ref) {
    return CustomModalsImpl(appState: ref.read(appStateProvider));
  }

  final AppState appState;

  BuildContext get context => appState.currentContext;

  @override
  void pop() => GoRouter.of(context).pop();

  @override
  Future<void> showLoadingDialog([BuildContext? context]) {
    return showDialog(
      context: context ?? this.context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: Container(
              width: 80,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Palette.current.appleGreenLight,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> showEditClient({
    BuildContext? context,
    required ClientModel client,
    required WidgetRef ref,
  }) {
    final TextEditingController firstnameController =
        TextEditingController(text: client.firstname);
    final TextEditingController lastnameController =
        TextEditingController(text: client.lastname);
    final TextEditingController emailController =
        TextEditingController(text: client.email);

    return showDialog(
      context: context ?? this.context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context ?? this.context).size.width * 0.8,
            height: MediaQuery.of(context ?? this.context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add new client',
                  style: FontConstants.body2.copyWith(
                    fontSize: 17,
                    color: Palette.current.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Palette.current.appleGreenLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50))),
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(50), // Image radius
                        child: FadeInImage(
                          placeholder: const AssetImage(Imagen.loading),
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.asset(Imagen.errorImg),
                          image: NetworkImage(client.photo!),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Mail',
                      controller: firstnameController,
                    ),
                    CustomTextFormField(
                      hintText: 'Mail',
                      controller: lastnameController,
                    ),
                    CustomTextFormField(
                      hintText: 'Mail',
                      controller: emailController,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context ?? this.context).pop();
                      },
                      child: Text(
                        'close',
                        style: FontConstants.body2.copyWith(
                          color: Palette.current.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    BorderButton(
                      maxHeight: 45,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text('SAVE',
                            style: FontConstants.body2.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      onPressed: () {
                        ref.read(homeProvider.notifier).updateClients(
                              client.copyWith(
                                firstname: firstnameController.text,
                                lastname: lastnameController.text,
                                email: emailController.text,
                              ),
                            );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> showAddClient({
    BuildContext? context,
    required WidgetRef ref,
  }) {
    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return showDialog(
      context: context ?? this.context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context ?? this.context).size.width * 0.8,
            height: MediaQuery.of(context ?? this.context).size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit client',
                  style: FontConstants.body2.copyWith(
                    fontSize: 17,
                    color: Palette.current.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(50),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        width: 100,
                        child: InkWell(
                            radius: 50,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            onTap: () {},
                            child: Image.asset(Imagen.loadPhotoImg)),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'First name*',
                      controller: firstnameController,
                    ),
                    CustomTextFormField(
                      hintText: 'Last name*',
                      controller: lastnameController,
                    ),
                    CustomTextFormField(
                      hintText: 'Email address*',
                      controller: emailController,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context ?? this.context).pop();
                      },
                      child: Text(
                        'close',
                        style: FontConstants.body2.copyWith(
                          color: Palette.current.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    BorderButton(
                      maxHeight: 45,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text('SAVE',
                            style: FontConstants.body2.copyWith(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                      onPressed: () {
                        ref.read(homeProvider.notifier).createClients(
                              ClientModel(
                                firstname: firstnameController.text,
                                lastname: lastnameController.text,
                                email: emailController.text,
                              ),
                            );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void removeDialog([BuildContext? context]) =>
      Navigator.of(context ?? this.context).pop();

  @override
  Future<void> showErrorDialog([BuildContext? context]) {
    return showDialog(
      context: context ?? this.context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context ?? this.context).size.width * 0.8,
            height: MediaQuery.of(context ?? this.context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ups!!!',
                  style: FontConstants.heading2.copyWith(
                    color: Palette.current.errorDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'An unexpected error',
                  style: FontConstants.heading2.copyWith(
                    fontSize: 14,
                    color: Palette.current.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: SizedBox.fromSize(
                    child: SizedBox(
                      width: 100,
                      child: Image.asset(Imagen.errorApi),
                    ),
                  ),
                ),
                BorderButton(
                  maxHeight: 45,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('CLOSE',
                        style: FontConstants.body2.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  onPressed: () {
                    Navigator.of(context ?? this.context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> showSuccesDialog([BuildContext? context]) {
    return showDialog(
      context: context ?? this.context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          elevation: 0,
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context ?? this.context).size.width * 0.8,
            height: MediaQuery.of(context ?? this.context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SUCCESSFUL!!!',
                  style: FontConstants.heading2.copyWith(
                    color: Palette.current.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Task completed successfully',
                  style: FontConstants.heading2.copyWith(
                    fontSize: 14,
                    color: Palette.current.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(50),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Palette.current.appleGreenLight,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        width: 100,
                        child: Image.asset(Imagen.successfulImg),
                      ),
                    ),
                  ),
                ),
                BorderButton(
                  maxHeight: 45,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('CLOSE',
                        style: FontConstants.body2.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  onPressed: () {
                    Navigator.of(context ?? this.context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
