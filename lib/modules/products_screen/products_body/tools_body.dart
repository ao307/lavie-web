import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/components/constants.dart';

import '../../../models/add_to_cart_model.dart';
import '../../../shared/components/responsive.dart';
import '../../../shared/components/widgets.dart';
import '../../../shared/cubit/products_cubit/products_cubit.dart';
import '../../../shared/cubit/products_cubit/products_states.dart';
import '../products_widgets/tools_item.dart';

class ToolsBody extends StatelessWidget {
  const ToolsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productScreenCubit = ProductsCubit.get(context);
    print(MediaQuery.of(context).size.width.toString());
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(productScreenCubit.productTool.isEmpty){
          return const EmptyWidget();
        }
        return GridView.builder(
          itemCount: productScreenCubit.productTool.length,
          padding: const EdgeInsets.symmetric(
            horizontal: paddingMedium,
            vertical: paddingLarge * 1.5,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isMobile(context) != true ? 5 : 3,
            childAspectRatio: 3 / 4.4,
            crossAxisSpacing: paddingMedium,
            mainAxisSpacing: paddingLarge * 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ToolsGridItem(
              count: productScreenCubit.toolsCount[index],
              data: productScreenCubit.productTool[index],
              addFun: () => productScreenCubit.addToolsFun(index),
              minusFun: () => productScreenCubit.minusToolsFun(index),
              addToCart: () => productScreenCubit.addToCart(
                DataCard(
                  cartCount: productScreenCubit.plantsCount[index],
                  imageUrl: productScreenCubit.productTool[index].imageUrl,
                  name: productScreenCubit.productTool[index].name,
                  price: productScreenCubit.productTool[index].price,
                  productId: productScreenCubit.productTool[index].productId,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
