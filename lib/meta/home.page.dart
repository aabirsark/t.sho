import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_sho/app/constants.dart';
import 'package:t_sho/meta/onboarding.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  bool showFAB = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset > 100) {
        setState(() {
          showFAB = true;
        });
      } else {
        setState(() {
          showFAB = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: showFAB
          ? FloatingActionButton.extended(
              onPressed: () {
                scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(CupertinoIcons.arrowtriangle_up),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Back to Top"),
                ],
              ))
          : null,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          Icon(
            Iconsax.home,
            color: buttonColor,
          ),
          Icon(Iconsax.search_normal),
          Icon(Iconsax.heart),
          Icon(Iconsax.profile_circle)
        ],
        backgroundColor: scaffoldColor,
        height: 60,
      ),
      body: FadeInUp(
        child: CustomScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              // pinned: true,
              floating: true,
              leading: const Icon(Iconsax.menu),
              backgroundColor: scaffoldColor,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Iconsax.bag))
              ],
              centerTitle: true,
              title: RichText(
                  text:
                      const TextSpan(style: TextStyle(fontSize: 18), children: [
                TextSpan(
                    text: "T",
                    style: TextStyle(
                        fontSize: 22,
                        color: buttonColor,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: " .SHO",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ])),
            ),
            SliverPersistentHeader(delegate: SearchBar()),
            SliverPersistentHeader(delegate: PopularCards()),
            SliverPersistentHeader(delegate: TextHeader()),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCardGrid(
                          arcColor: index % 2 == 0
                              ? const Color(0xFFbde0fe)
                              : const Color(0xFFf28482),
                        )),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7))
          ],
        ),
      ),
    );
  }
}

class ProductCardGrid extends StatelessWidget {
  const ProductCardGrid({
    Key? key,
    required this.arcColor,
  }) : super(key: key);

  final Color arcColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(18),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomPaint(
                      painter: Arc(150, 150, arcColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "5",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          CupertinoIcons.star_fill,
                          size: 14,
                          color: buttonColor,
                        )
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Iconsax.add_circle),
                  ),
                  Positioned(
                      child: Transform.rotate(
                    angle: pi * 1.9,
                    child: Image.asset(
                      "assets/onboarding_shoes.png",
                    ),
                  ))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "x Dior Air Jordan",
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          const Text(
            "\$300",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class TextHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "New Arrivals",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "See all",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class PopularCards extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  2,
                  (index) => PopularCard(
                        color: index % 2 == 0
                            ? buttonColor
                            : const Color(0xFFcdb4db),
                      )),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 250;

  @override
  double get minExtent => 250;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(right: 10),
      height: 180,
      width: 280,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black26,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "5",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  CupertinoIcons.star_fill,
                  size: 20,
                  color: buttonColor,
                )
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Icon(Iconsax.add_circle),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomPaint(
              painter: Arc(150, 150, color),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Transform.rotate(
                angle: pi * 1.9,
                child: Image.asset(
                  "assets/onboarding_shoes.png",
                  height: 100,
                ),
              )),
          Positioned(
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jordan",
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "\$551",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  // width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: ShapeDecoration(
                      shape: const StadiumBorder(), color: color),
                  child: const Center(
                    child: Text(
                      "Check out",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(10)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Search"),
            Icon(
              Iconsax.search_normal,
              color: Colors.white38,
            )
          ]),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
