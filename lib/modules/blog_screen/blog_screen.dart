import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/modules/blog_screen/blog_widgets/blogs_plant_item.dart';
import 'package:lavie_web/modules/blog_screen/blog_widgets/blogs_seeds_item.dart';
import 'package:lavie_web/modules/blog_screen/blog_widgets/blogs_tools_item.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/components/widgets.dart';
import 'package:lavie_web/shared/cubit/products_cubit/products_cubit.dart';
import '../../layout/web_base_tab/web_base_tab.dart';
import '../../shared/cubit/products_cubit/products_states.dart';
import '../product_scan_screen/scan_product_screen.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsCubit productsCubit = ProductsCubit.get(context);
    return FutureBuilder(
      future: productsCubit.getBlogs(),
      builder: (context, snapshot) {
        return BlocConsumer<ProductsCubit, ProductsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                productsCubit.blogsModel == null) {
              return const LoadingPage();
            } else if (productsCubit.blogsModel == null || snapshot.hasError) {
              return const ErrorPage();
            }
            final toLengthIf = productsCubit.blogsModel!.data;
            return BaseWidget(
              child: toLengthIf!.seeds!.isNotEmpty &&
                      toLengthIf.plants!.isNotEmpty &&
                      toLengthIf.tools!.isNotEmpty
                  ? Column(
                      children: [
                        Text(
                          'blogs'.tr().toTitleCase(),
                          style: const TextStyle(
                            fontSize: textSizeLarge,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: paddingLarge * 3,
                              ),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                      top: paddingLarge * 2,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: productsCubit
                                        .blogsModel!.data!.plants!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: paddingLarge * 2,
                                      mainAxisSpacing: paddingLarge * 2,
                                      childAspectRatio: 1.16,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BlogsPlantItem(
                                      model: productsCubit
                                          .blogsModel!.data!.plants![index],
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          widget: ScanProductScreen(
                                            imageUrl: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .plants![index]
                                                    .imageUrl ??
                                                '',
                                            name: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .plants![index]
                                                    .name ??
                                                '',
                                            description: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .plants![index]
                                                    .description ??
                                                '',
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: productsCubit
                                        .blogsModel!.data!.seeds!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: paddingLarge * 2,
                                      mainAxisSpacing: paddingLarge * 2,
                                      childAspectRatio: 1.16,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BlogsSeedItem(
                                      model: productsCubit
                                          .blogsModel!.data!.seeds![index],
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: productsCubit
                                        .blogsModel!.data!.tools!.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: paddingLarge * 2,
                                      mainAxisSpacing: paddingLarge * 2,
                                      childAspectRatio: 1.16,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BlogsToolsItem(
                                      model: productsCubit
                                          .blogsModel!.data!.tools![index],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const EmptyWidget(),
            );
          },
        );
      },
    );
  }
}
