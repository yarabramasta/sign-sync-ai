import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';
import 'package:signsyncai/features/chats/presentation/actions.dart';
import 'package:signsyncai/ui/utils/sizes.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<void> showSearchLectureBottomSheet(
  BuildContext context,
) {
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
                  child: RearchBuilder(builder: (context, use) {
                    final (_, search) = use(searchLecture);

                    use.effect(() {
                      search(null, context);
                      return null;
                    }, []);

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        onSubmitted: (value) {
                          search(value, context);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search lecture',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                    child: RearchBuilder(
                      builder: (context, use) {
                        final (state, _) = use(searchLecture);
                        final (_, create) = use(createConversation);
                        final account = use(account$);

                        if (state is AsyncLoading) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Sizes.p24,
                              horizontal: Sizes.p12,
                            ),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        return switch (state) {
                          AsyncData(:final data) => Padding(
                              padding: const EdgeInsets.only(bottom: Sizes.p12),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      final curentUser = account.dataOr(null);
                                      if (curentUser == null) return;

                                      create(
                                        context,
                                        {
                                          'sender': curentUser,
                                          'receiver': data[index],
                                        },
                                      );
                                    },
                                    title: Text(data[index].name ?? 'Loading'),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        data[index].avatar!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          _ => const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.p24,
                                horizontal: Sizes.p12,
                              ),
                              child: Center(child: Text('No data')),
                            ),
                        };
                      },
                    ),
                  )
                ],
              )
            ];
          },
        ),
      ];
    },
  );
}
