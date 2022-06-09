import 'package:flutter/material.dart';
import 'package:mentor_mentee_connecting/Theme/color.dart';
import 'package:mentor_mentee_connecting/Widgets/recommend_item.dart';
import 'package:mentor_mentee_connecting/utils/data.dart';
import 'package:mentor_mentee_connecting/widgets/category_item.dart';
import 'package:mentor_mentee_connecting/widgets/custom_textfield.dart';
import 'package:mentor_mentee_connecting/widgets/feature_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getHeader(),
              bottom: getSearchBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => getSearchCourses(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  // buildBody() {
  //   return SingleChildScrollView(
  //     child: Column(children: [
  //       getSearchCourses(),
  //     ]),
  //   );
  // }

  getHeader() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(0, 48, 0, 4),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search Course",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          ],
        ));
  }

  getSearchBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: CustomTextBox(
                hint: "Search",
                prefix: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            buildCategory()
          ],
        ));
  }

  getSearchCourses() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(top: 8),
        child: Column(
            children: List.generate(
                features.length,
                (index) => Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: RecommendItem(
                        onTap: () {},
                        data: features[index],
                      ),
                    ))),
      ),
    );
  }

  int selectedCategoryIndex = 0;
  Widget buildCategory() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CategoryItem(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              data: categories[index],
              isSelected: index == selectedCategoryIndex,
              onTap: () {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
