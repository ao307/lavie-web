import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/auth_screens/auth_widgets/auth_button.dart';
import 'package:lavie_web/modules/cart_screen/cart_screen_widgets/cart_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/cubit/products_cubit/products_cubit.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/components/widgets.dart';
import '../../shared/cubit/products_cubit/products_states.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productsCubit = ProductsCubit.get(context);
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BaseWidget(
          child: productsCubit.listOfDataCart.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: productsCubit.listOfDataCart.length,
                        padding: const EdgeInsetsDirectional.all(paddingLarge),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: paddingLarge,
                        ),
                        itemBuilder: (BuildContext context, int index) =>
                            CartItem(
                          counter: productsCubit.cartCount[index],
                          model: productsCubit.listOfDataCart[index],
                          addFun: () => productsCubit.addDataCartFun(index),
                          minFun: () => productsCubit.minusDataCartFun(index),
                          delete: () => productsCubit.clearItemCart(index),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingLarge,
                        vertical: paddingLarge * 2,
                      ),
                      child: AuthButton(text: 'checkout'),
                    )
                  ],
                )
              : const EmptyWidget(
                  title: "your cart is empty",
                  subTitle:
                      "sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                ),
        );
      },
    );
  }
}
