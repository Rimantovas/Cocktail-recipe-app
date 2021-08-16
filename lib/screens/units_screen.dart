import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/src/provider.dart';
import 'package:recipeapp/common/common.dart';
import 'package:recipeapp/styling/styling.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class UnitsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final unitsModel = context.watch<Units>();
    var units = unitsModel.returnMap();
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.primaryColor,
        ),
        body: Column(
          children: [
            buildHeader(screenHeight, "CONVERTER HELPER TOOL",
                "So you have less things to think about"),
            Expanded(
              child: CustomScrollView(
                reverse: false,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 20),
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.black12),
                                child: Text(
                                  "SELECT FROM THE GIVEN OPTIONS\nACCORDING TO YOUR NEEDS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Palette.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          DefaultTabController(
                            initialIndex: unitsModel.index,
                            length: 2,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Palette.primaryColor,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: TabBar(
                                indicator: BubbleTabIndicator(
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                  indicatorHeight: 40.0,
                                  indicatorColor: Colors.white,
                                ),
                                labelStyle: Styles.tabTextStyle,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.white,
                                tabs: <Widget>[
                                  Text('To Metric'),
                                  Text('To Imperial'),
                                ],
                                onTap: (index) {
                                  print(index);
                                  unitsModel.changeIndex(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    fillOverscroll: true,
                    hasScrollBody: false,
                    child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: Palette.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          Text(
                            "CONVERTER",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white70),
                          ),
                          for (var item in units.keys)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    item,
                                    style: Styles.ingridientStyle
                                        .copyWith(color: Colors.white),
                                  ),
                                  VerticalDivider(
                                    thickness: 1,
                                    width: 1,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    units[item] ?? "",
                                    style: Styles.ingridientStyle
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            )

                          // Expanded(
                          //   child: ListView.builder(
                          //       itemCount: units.length,
                          //       itemBuilder: (context, item) {
                          //         return Row(
                          //           children: [
                          //             Text(units.keys.elementAt(item)),
                          //             VerticalDivider(),
                          //             Text(units[item] ?? ""),
                          //           ],
                          //         );
                          //       }),
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
