import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigator/main.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Root Screen'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final page = ref.watch(pageIndicator);
          return page == 0
              ? Container(
                  color: Colors.amberAccent,
                )
              : page == 1
                  ? Container(
                      color: Colors.redAccent,
                    )
                  : page == 2
                      ? Container(
                          color: Colors.blueGrey,
                        )
                      : Container(
                          color: Colors.blueAccent,
                        );
        },
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFFFFFFFF)),
        child: Consumer(builder: (context, ref, child) {
          final page = ref.watch(pageIndicator);

          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.lightGreen,
            currentIndex: int.parse(page.toString()),
            onTap: (value) {
              ref.read(pageIndicator.notifier).updatePage(value);
            },
            //  model.updateScreenIndex,
            // selectedLabelStyle: TextStyle(
            //   fontFamily: 'PlusJakartaSans',
            //   fontSize: 10.sp,
            //   fontWeight: FontWeight.w700,
            // ),
            // selectedLabelStyle: kActiveNavBarLabelTextStyle,
            // unselectedLabelStyle: kNonActiveNavBarLabelTextStyle,
            items: const [
              BottomNavigationBarItem(
                label: 'HOME',
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.home_filled,
                    //  color: ,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'FAVORITES',
                icon: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.local_convenience_store_outlined,
                      //  color: ,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'DATA',
                icon: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.data_saver_off,
                      //  color: ,
                    )),
              ),
              BottomNavigationBarItem(
                label: 'PROFILE',
                icon: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.person,
                      //  color: ,
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }
}
