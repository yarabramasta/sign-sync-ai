import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<void> showSearchLectureBottomSheet(BuildContext context) {
  return WoltModalSheet.show(
    context: context,
    useRootNavigator: true,
    useSafeArea: true,
    pageListBuilder: (context) {
      return [
        SliverWoltModalSheetPage(
          hasTopBarLayer: true,
          useSafeArea: true,
          navBarHeight: 20,
          mainContentSliversBuilder: (context) {
            return [
              SliverPadding(
                padding: const EdgeInsets.all(10.0),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search lecture',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/a/ACg8ocJN-jbq5VLnzo8J9pjzxp3UAjMgqPrck_JcxfiklQGTqkTqRp4=s96-c',
                      ),
                    ),
                    title: Text('Mr. Firnanda Achyunda'),
                  ),
                  childCount: 10, // Jumlah dosen
                ),
              )
            ];
          },
        ),
      ];
    },
  );
}
