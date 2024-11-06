import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/custom_modals/custom_modals.dart';
import 'package:tots_test/constant/imagen.dart';
import 'package:tots_test/features/home/model/clients_model.dart';
import 'package:tots_test/utils/custom_font_style.dart';
import 'package:tots_test/utils/palette.dart';

class CardClient extends ConsumerWidget {
  const CardClient({
    super.key,
    required this.client_,
  });

  final ClientModel client_;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Palette.current.black),
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(25))),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Palette.current.appleGreenLight,
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            width: 50,
            height: 50,
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(25), // Image radius
                child: FadeInImage(
                  placeholder: const AssetImage(Imagen.loading),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(Imagen.errorImg),
                  image: NetworkImage(client_.photo!),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  client_.firstname!,
                  style: FontConstants.body2.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    client_.email!,
                    style: FontConstants.body2
                        .copyWith(fontSize: 12, color: Palette.current.grey),
                  ))
            ],
          ),
          const Spacer(),
          RotatedBox(
            quarterTurns: 3,
            child: IconButton(
                onPressed: () {
                  ref.read(customModalsProvider).showEditClient(
                      client: client_, context: context, ref: ref);
                },
                icon: const Icon(Icons.more_horiz_rounded)),
          )
        ],
      ),
    );
  }
}
