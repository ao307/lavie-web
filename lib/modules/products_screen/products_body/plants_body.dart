import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/components/constants.dart';
import '../../../models/add_to_cart_model.dart';
import '../../../shared/components/responsive.dart';
import '../../../shared/components/reuse_functions.dart';
import '../../../shared/components/widgets.dart';
import '../../../shared/cubit/products_cubit/products_cubit.dart';
import '../../../shared/cubit/products_cubit/products_states.dart';
import '../../single_product_screen/single_product_screen.dart';
import '../products_widgets/plants_item.dart';

class PlantsBody extends StatelessWidget {
  const PlantsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productScreenCubit = ProductsCubit.get(context);
    return BlocConsumer<ProductsCubit, ProductsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(productScreenCubit.productPlant.isEmpty){
          return const EmptyWidget();
        }
        return GridView.builder(
          itemCount: productScreenCubit.productPlant.length,
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
            return PlantsGridItem(
              count: productScreenCubit.plantsCount[index],
              data: productScreenCubit.productPlant[index],
              addFun: () => productScreenCubit.addPlantFun(index),
              minusFun: () => productScreenCubit.minusPlantFun(index),
              addToCart: () => productScreenCubit.addToCart(
                DataCard(
                  cartCount: productScreenCubit.plantsCount[index],
                  imageUrl: productScreenCubit.productPlant[index].imageUrl,
                  name: productScreenCubit.productPlant[index].name,
                  price: productScreenCubit.productPlant[index].price,
                  productId: productScreenCubit.productPlant[index].productId,
                ),
              ),
              onTap: (){
                navigateTo(
                  context: context,
                  widget: SingleProductScreen(
                    productData: productScreenCubit.productPlant[index],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
