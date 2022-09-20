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
import '../single_blog_screen/single_product_screen.dart';

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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: paddingLarge * 1.5,
                          ),
                          child: Text(
                            'blogs'.tr().toTitleCase(),
                            style: const TextStyle(
                              fontSize: textSizeLarge * 1.2,
                            ),
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
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          screenW(context) <= 863 ? 2 : 3,
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
                                          widget: SingleBlogScreen(
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
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          screenW(context) <= 863 ? 2 : 3,
                                      crossAxisSpacing: paddingLarge * 2,
                                      mainAxisSpacing: paddingLarge * 2,
                                      childAspectRatio: 1.16,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BlogsSeedItem(
                                      model: productsCubit
                                          .blogsModel!.data!.seeds![index],
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          widget: SingleBlogScreen(
                                            imageUrl: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .seeds![index]
                                                    .imageUrl ??
                                                '',
                                            name: productsCubit.blogsModel!
                                                    .data!.seeds![index].name ??
                                                '',
                                            description: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .seeds![index]
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
                                        .blogsModel!.data!.tools!.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          screenW(context) <= 863 ? 2 : 3,
                                      crossAxisSpacing: paddingLarge * 2,
                                      mainAxisSpacing: paddingLarge * 2,
                                      childAspectRatio: 1.16,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            BlogsToolsItem(
                                      model: productsCubit
                                          .blogsModel!.data!.tools![index],
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          widget: SingleBlogScreen(
                                            imageUrl: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .tools![index]
                                                    .imageUrl ??
                                                '',
                                            name: productsCubit.blogsModel!
                                                    .data!.tools![index].name ??
                                                '',
                                            description: productsCubit
                                                    .blogsModel!
                                                    .data!
                                                    .tools![index]
                                                    .description ??
                                                '',
                                          ),
                                        );
                                      },
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
