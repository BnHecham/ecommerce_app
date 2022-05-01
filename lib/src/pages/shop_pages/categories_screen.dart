import 'package:ecommerce_app/src/pages/shop_pages/specific_category.dart';
import 'package:ecommerce_app/src/pages/user_pages/userScreen.dart';
import 'package:ecommerce_app/src/services/extensions.dart';
import '../../config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/route.dart';
import '../../provider/category_provider.dart';
import '../../widgets/build_app_bar.dart';
import '../../widgets/page_layout.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryProvider>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          customAppBar(context, actionMethod: 'user', leading: false,
              actionOnTap: () {
            push(const UserScreen());
          }),
        ],
        body: buildPage(context,
            child: buildGridView(), topText: 'Our', bottomText: 'Categories'),
      ),
    );
  }

  Widget buildGridView() => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 1),
      padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
      itemCount: context.watch<CategoryProvider>().categories.length,
      itemBuilder: (context, _index) {
        return _categoryCardGrid(_index);
      });

  Widget _categoryCardGrid(int index) {
    return Consumer<CategoryProvider>(
      builder: (context, category, child) => Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
                    image: NetworkImage(category.showCategoriesList[index]),
                    colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.40), BlendMode.darken),
                    fit: BoxFit.cover,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  category.categories[index].name!,
                  style: AppTheme.h1Style.copyWith(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ).onTap(() {
          category.categoryId = category.categories[index].id!;
          int _id = category.categories[index].id!;
          switch (_id) {
            case 1:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
            case 2:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
            case 3:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
            case 4:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
            case 5:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
            case 6:
              category.products = [];
              category.getProductsByCategoryId(index + 1);
              push(SpecificCategory(index: index));
              break;
          }
        }),
      ),
    );
  }
}
