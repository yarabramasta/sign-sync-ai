import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/ui/toast.dart';
import 'package:signsyncai/ui/utils/sizes.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<String?> showRecordModal(BuildContext context) {
  final speechClient = SpeechToText();

  return WoltModalSheet.show<String>(
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
                    final (text, setText) = use.state('');

                    use.callonce(() {
                      speechClient.initialize();
                    });

                    void startListening() async {
                      try {
                        speechClient.listen(
                          localeId: 'id_ID',
                          onResult: (result) {
                            setText(result.recognizedWords);
                          },
                        );
                      } on ListenFailedException catch (e) {
                        context.toast.error(
                          message: e.message ?? 'Gagal melakukan record audio',
                          autoCloseDuration: const Duration(seconds: 3),
                        );
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onLongPressStart: (details) => startListening(),
                            onLongPressEnd: (details) => speechClient.stop(),
                            onTap: text.isEmpty
                                ? null
                                : () {
                                    Navigator.pop(context, text);
                                    setText('');
                                  },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: PhosphorIcon(
                                text == ''
                                    ? PhosphorIconsRegular.microphone
                                    : PhosphorIconsRegular.paperPlaneTilt,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(Sizes.p32),
                            child: Text(
                              text == ''
                                  ? 'Tekan & tahan untuk berbicara'
                                  : text,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ];
          },
        )
      ];
    },
  );
}
