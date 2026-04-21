import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:aqar360/app/features/home/presentation/screens/node_add_screen.dart';
import 'package:aqar360/app/features/home/presentation/widgets/bottom_nav_item.dart';
import 'package:aqar360/app/features/home/presentation/widgets/cliper_nav_bar.dart';
import 'package:aqar360/app/features/home/presentation/widgets/customer_bottom_navigation_bar.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_app_logo.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/custom_top_brand_bar.dart';
import 'package:aqar360/app/features/onboarding/presentation/widgets/head_line_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>> getNotes() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("notes")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("createdAt", descending: true)
        .get();

    return querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,

      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 70,
                child: FittedBox(
                  child: HeadlineTextWidget(
                    title1: AppStrings.exploreRealEstate,
                    title2: AppStrings.tenthOfRamadan,
                    fontSize: 30,
                    colorT1: AppColors.black,
                  ),
                ),
              ),

              SizedBox(height: 14, width: double.infinity),
              Expanded(
                child: FutureBuilder(
                  future: getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("لا يوجد ملاحظات"));
                    }

                    final notes = snapshot.data as List<Map<String, dynamic>>;

                    return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),

                            title: Text(
                              note["name"] ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                note["description"] ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            trailing: const Icon(Icons.note_alt_outlined),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsetsGeometry.only(bottom: 8),
            child: CustomAppLogo(height: 60, width: 80),
          ),
          title: Padding(
            padding: EdgeInsetsGeometry.only(bottom: 8),
            child: CustomTopBrandBar(
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: .w700),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                color: AppColors.slateBlueGray,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person_2,
                color: AppColors.slateBlueGray,
                size: 35,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 75,
          height: 75,
          child: FloatingActionButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => Dialog(child: NoteAddScreen()),
              );
              setState(() {});
            },
            shape: const CircleBorder(),
            child: Icon(Icons.add, size: 40),
          ),
        ),
        bottomNavigationBar: ClipPath(
          clipper: CustomNavigationBar(),
          child: CustomBottomNavigationBar(
            actions: [
              BottomNavItem(
                icon: Icons.home,
                title: "الرئسية",
                index: 0,
                currentIndex: 1,
                onTap: (p1) {},
              ),
              BottomNavItem(
                icon: Icons.search,
                title: "Search",
                index: 1,
                currentIndex: 1,
                onTap: (p1) {},
              ),

              SizedBox(width: 60),

              BottomNavItem(
                icon: Icons.favorite,
                title: "Fav",
                index: 2,
                currentIndex: 1,

                onTap: (int p1) {
                  // cubit.setCurrentIndex(p1);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FavoriteScreen()),
                  // );
                },
              ),
              BottomNavItem(
                icon: Icons.person,
                title: "Profile",
                index: 3,
                currentIndex: 1,
                onTap: (p1) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
