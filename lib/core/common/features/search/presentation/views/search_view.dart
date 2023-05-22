import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
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
              trailing: provider.searchController.text.isEmpty ? null : [
                IconButton(
                  icon: Icon(Icons.close, color: state.accentColor),
                  onPressed: provider.clearSearch,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
