import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lavie_web/modules/products_screen/products_widgets/search_text_form.dart';
import 'package:lavie_web/modules/products_screen/search_product_screen/search_product_screen.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/components/widgets.dart';

import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/tap_bar_reuse.dart';
import '../../shared/cubit/products_cubit/products_cubit.dart';
import '../../shared/cubit/products_cubit/products_states.dart';
import '../cart_screen/cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productScreenCubit = ProductsCubit.get(context);
    return FutureBuilder(
      future: productScreenCubit.getProducts(),
      builder: (context, snapshot) {
        return BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                productScreenCubit.productsModel == null) {
              return const LoadingPage(
              );
            } else if (snapshot.hasError ||
                state is GetProductsDataErrorState) {
              return const ErrorPage(
              );
            }
            return BaseWidget(
              // floatingActionButton: FloatingActionButton(
              //   tooltip: 'blogsGo',
              //   child: const Icon(
              //     Icons.question_mark_outlined,
              //     color: Colors.white,
              //     size: 30,
              //   ),
              //   onPressed: () {
              //     navigateTo(context: context, widget: const BlogsScreen());
              //   },
              // ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: paddingMedium),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchTextFormField(
                            hintText: 'search',
                            readOnly: true,
                            onTap: (){
                              navigateTo(context: context, widget: const SearchProductsScreen());
                            },
                          ),
                        ),
                        const SizedBox(
                          width: paddingMedium,
                        ),
                        FloatingActionButton(
                          heroTag: "productScreen",
                          onPressed: () {
                            navigateTo(
                                context: context, widget: const MyCartScreen(),);
                          },
                          mini: true,
                          child: const FaIcon(
                            IconlyLight.buy,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: paddingLarge),
                  Expanded(
                    child: TapBarReUse(
                      initialIndex: productScreenCubit.indexOfProductTap,
                      listOfTabsText: productScreenCubit.tapTextOfProduct,
                      listOfViewsBody: productScreenCubit.bodyOfProduct,
                      onChange: (index) =>
                          productScreenCubit.changeIndexOfTap(index),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
