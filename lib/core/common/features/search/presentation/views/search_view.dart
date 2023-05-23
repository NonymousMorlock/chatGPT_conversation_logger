import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/core/extensions/date_extensions.dart';
import 'package:conversation_log/core/utils/functions.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return SearchBar(
              controller: provider.searchController,
              onTap: () {
                if (provider.searchController.text.isNotEmpty &&
                    provider.lastPickedDate != null &&
                    provider.searchController.text ==
                        provider.lastPickedDate!.plainDate) {
                  provider.clearSearch();
                }
              },
              trailing: [
                if (provider.searchController.text.isNotEmpty)
                  IconButton(
                    icon: Icon(Icons.close, color: state.accentColor),
                    onPressed: provider.clearSearch,
                  ),

                // date picker
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: state.accentColor,
                  ),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: provider.lastPickedDate ?? DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      if (!provider.searchByDate(date)) {
                        await showPlatformDialog(
                          windowTitle: 'No conversation found',
                          text: 'No conversation found for ${date.plainDate}',
                          noNegativeButton: true,
                          positiveButtonTitle: 'Ok',
                        );
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
