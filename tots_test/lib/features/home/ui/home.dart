import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_test/components/button/border_button.dart';
import 'package:tots_test/components/card/custom_card_client.dart';
import 'package:tots_test/components/custom_modals/custom_modals.dart';
import 'package:tots_test/components/loading/loading_widget.dart';
import 'package:tots_test/components/scaffold/custom_scaffold.dart';
import 'package:tots_test/components/textfromfield/custom_text_from_field.dart';
import 'package:tots_test/constant/icons.dart';
import 'package:tots_test/constant/imagen.dart';
import 'package:tots_test/features/home/model/clients_model.dart';
import 'package:tots_test/features/home/provider/home_provider.dart';
import 'package:tots_test/utils/custom_font_style.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  ConsumerState<HomePage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<HomePage> {
  bool showMore = false;
  bool isFiltered = false;
  String searchQuery = "";
  List<ClientModel> filteredClients = [];
  final TextEditingController controllerSeachrtClient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    void updateSearchQuery(String query) {
      setState(() {
        isFiltered = true;
        showMore = true;
        searchQuery = query;
        filteredClients = state.clients!.where((client) {
          final fullName =
              '${client.firstname} ${client.lastname}'.toLowerCase();
          return fullName.contains(searchQuery.toLowerCase());
        }).toList();
      });
    }

    return CustomScaffoldWidget(
      imgBackground: Imagen.homeBackgroundImg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  Imagen.iconAppImg,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.56,
                  child: CustomTextFormField(
                    onChange: (query) => updateSearchQuery(query),
                    prefixImage: IconConstants.searchIcon,
                    hintText: 'Search....',
                    controller: controllerSeachrtClient,
                    withBorder: true,
                  ),
                ),
                BorderButton(
                  maxHeight: 45,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('ADD NEW',
                        style: FontConstants.body2.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                  onPressed: () {
                    ref.read(customModalsProvider).showAddClient(
                          context: context,
                          ref: ref,
                        );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: Text(
                'CLIENTS',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            if (state.clients != null && state.clients!.isNotEmpty) ...[
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: showMore
                    ? isFiltered
                        ? filteredClients.length
                        : state.clients!.length
                    : 5,
                itemBuilder: (context, index) {
                  final client_ = isFiltered
                      ? filteredClients[index]
                      : state.clients![index];
                  return CardClient(client_: client_);
                },
              )
            ] else ...[
              const LoadingWidget()
            ],
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: BorderButton(
                title: Text(showMore ? 'SEE LESS' : 'LOAD  MORE',
                    style: FontConstants.body2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
                onPressed: () {
                  setState(() {
                    controllerSeachrtClient.text = '';
                    filteredClients = state.clients!;
                    showMore = !showMore;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
