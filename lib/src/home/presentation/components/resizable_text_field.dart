import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ResizableTextField extends StatefulWidget {
  const ResizableTextField({super.key});

  @override
  State<ResizableTextField> createState() => _ResizableTextFieldState();
}

class _ResizableTextFieldState extends State<ResizableTextField> {
  double staticWidth = 200;
  double staticHeight = 70;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        return SizedBox(
          width: provider.width,
          height: provider.height,
          child: Stack(
            children: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return TextField(
                    textAlignVertical: TextAlignVertical.top,
                    style: state is DarkTheme
                        ? const TextStyle(color: Colors.white)
                        : null,
                    controller: provider.controller,
                    focusNode: provider.focus,
                    expands: true,
                    maxLines: null,
                    maxLength: TextField.noMaxLength,
                    decoration: InputDecoration(
                      hintText: provider.hint,
                      hintStyle: TextStyle(color: state.primaryTextColor),
                      counterStyle: TextStyle(color: state.primaryTextColor),
                      contentPadding: const EdgeInsets.all(16),
                      border: const OutlineInputBorder(),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: GestureDetector(
                  onPanUpdate: (DragUpdateDetails details) {
                    setState(() {
                      provider
                        ..updateWidth(
                          (provider.width + details.delta.dx).clamp(
                            staticWidth,
                            double.infinity,
                          ),
                        )
                        ..updateHeight(
                          (provider.height + details.delta.dy).clamp(
                            staticHeight,
                            double.infinity,
                          ),
                        );
                    });
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: const Icon(Icons.drag_handle),
                  ),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: GestureDetector(
              //     onPanUpdate: (DragUpdateDetails details) {
              //       setState(() {
              //         _width = (_width + details.delta.dx).clamp(
              //           staticWidth,
              //           double.infinity,
              //         );
              //       });
              //     },
              //     child: Container(
              //       width: 10,
              //       height: 10,
              //       decoration: const BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(5),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: GestureDetector(
              //     onPanUpdate: (DragUpdateDetails details) {
              //       setState(() {
              //         _height = (_height + details.delta.dy).clamp(
              //           staticHeight,
              //           double.infinity,
              //         );
              //       });
              //     },
              //     child: Container(
              //       width: 10,
              //       height: 10,
              //       decoration: const BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.only(
              //           bottomRight: Radius.circular(5),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
