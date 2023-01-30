import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/utils.dart';
import '../../../core/constants/constants.dart';
import '../../../riverpod/providers/providers.dart';
import '../../components/components.dart';
import '../../theme/theme.dart';
import 'widgets/language_item.dart';

class SelectLangPage extends ConsumerStatefulWidget {
  final bool isRequired;

  const SelectLangPage({Key? key, this.isRequired = false}) : super(key: key);

  @override
  ConsumerState<SelectLangPage> createState() => _SelectLangPageState();
}

class _SelectLangPageState extends ConsumerState<SelectLangPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        ref
            .read(selectLangProvider.notifier)
            .getLanguages(context, widget.isRequired);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(selectLangProvider.notifier);
    final appNotifier = ref.read(appProvider.notifier);
    final state = ref.watch(selectLangProvider);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(243, 243, 240, 1),
          appBar: CustomAppbar(
            title: AppHelpers.getTranslation(TrKeys.selectLanguage),
          ),
          body: state.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenMain,
                    strokeWidth: 2.r,
                  ),
                )
              : Column(
                  children: <Widget>[
                    SearchTextField(
                      hintText:
                          AppHelpers.getTranslation(TrKeys.searchLanguage),
                      onChanged: notifier.onSearch,
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.languages.length,
                        physics: const CustomBouncingScrollPhysics(),
                        padding: REdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        itemBuilder: (context, index) {
                          final language = state.languages[index];
                          final bool isSelected = state.selectedIndex == index;
                          return LanguageItem(
                            isChecked: isSelected,
                            text: language.title,
                            onPress: () => notifier.setLangIndex(index),
                            imageUrl: language.img,
                          );
                        },
                      ),
                    ),
                  ],
                ),
          extendBody: true,
          bottomNavigationBar: Padding(
            padding: REdgeInsets.only(bottom: 30, left: 15, right: 15),
            child: CommonAccentButton(
              title: AppHelpers.getTranslation(TrKeys.next),
              isLoading: state.isSaving,
              onPressed: () {
                if (widget.isRequired) {
                  notifier.makeSelectedLang(context, widget.isRequired);
                  appNotifier
                      .changeLocale(state.languages[state.selectedIndex]);
                } else {
                  notifier.changeLang(
                    context,
                    appNotifier,
                    widget.isRequired,
                    afterUpdating: () {
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
