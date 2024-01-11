import 'package:conversation_log/core/common/settings/cubit/setting_cubit.dart';
import 'package:conversation_log/core/common/theme/cubit/theme_cubit.dart';
import 'package:conversation_log/core/utils/general_utils.dart';
import 'package:conversation_log/src/home/presentation/app/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:menu_bar/menu_bar.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();
const kApplicationName = 'Conversation Log';
const kApplicationVersion = '1.0.0';
const kApplicationIcon = FlutterLogo();

const kConversationStoreKey = 'conversations';

final kMenuButtons = [
  BarButton(
    text: const Text('File'),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          onTap: kNavigatorKey.currentContext!
              .read<HomeProvider>()
              .saveConversations,
          text: const Text('Save'),
          shortcutText: 'Ctrl+S',
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Save as'),
          shortcutText: 'Ctrl+Shift+S',
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () async {
            final provider = kNavigatorKey.currentContext!.read<HomeProvider>();
            final result = await GeneralUtils.pickJsonFile();
            if (result != null) {
              provider.setConversationsFromFile(result);
            }
          },
          text: const Text('Open File'),
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Open Folder'),
        ),
        const MenuDivider(),
        MenuButton(
          text: const Text('Preferences'),
          icon: const Icon(Icons.settings),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                onTap: () {},
                icon: const Icon(Icons.keyboard),
                text: const Text('Shortcuts'),
              ),
              const MenuDivider(),
              MenuButton(
                onTap: () {},
                icon: const Icon(Icons.extension),
                text: const Text('Extensions'),
              ),
              const MenuDivider(),
              MenuButton(
                icon: const Icon(Icons.looks),
                text: const Text('Change theme'),
                submenu: SubMenu(
                  menuItems: [
                    MenuButton(
                      onTap: () {
                        kNavigatorKey.currentContext!
                            .read<SettingCubit>()
                            .toggleDarkModeOption(val: false);
                      },
                      icon: const Icon(Icons.light_mode),
                      text: const Text('Light theme'),
                    ),
                    const MenuDivider(),
                    MenuButton(
                      onTap: () {
                        kNavigatorKey.currentContext!
                            .read<SettingCubit>()
                            .toggleDarkModeOption(val: true);
                      },
                      icon: const Icon(Icons.dark_mode),
                      text: const Text('Dark theme'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const MenuDivider(),
        const MenuButton(
          onTap: FlutterWindowClose.closeWindow,
          shortcutText: 'Ctrl+Q',
          text: Text('Exit'),
          icon: Icon(Icons.exit_to_app),
        ),
      ],
    ),
  ),
  BarButton(
    text: const Text('Edit'),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          onTap: () {},
          text: const Text('Undo'),
          shortcutText: 'Ctrl+Z',
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Redo'),
          shortcutText: 'Ctrl+Y',
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {},
          text: const Text('Cut'),
          shortcutText: 'Ctrl+X',
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Copy'),
          shortcutText: 'Ctrl+C',
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Paste'),
          shortcutText: 'Ctrl+V',
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {},
          text: const Text('Find'),
          shortcutText: 'Ctrl+F',
        ),
      ],
    ),
  ),
  // View
  BarButton(
    text: const Text('View'),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          text: const Text('View Type'),
          submenu: SubMenu(
            menuItems: [
              MenuButton(
                onTap: () {
                  kNavigatorKey.currentContext!.read<HomeProvider>().viewType =
                      ViewType.EXPORTED;
                },
                text: const Text('Imported Conversations'),
              ),
              MenuButton(
                onTap: () {
                  kNavigatorKey.currentContext!.read<HomeProvider>().viewType =
                      ViewType.USER_FILLED;
                },
                text: const Text('Filled Conversations'),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  BarButton(
    text: const Text('Help'),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          onTap: () {},
          text: const Text('Check for updates'),
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {
            showLicensePage(
              context: kNavigatorKey.currentContext!,
              applicationName: kApplicationName,
              applicationVersion: kApplicationVersion,
              applicationIcon: kApplicationIcon,
            );
          },
          text: const Text('View License'),
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {
            showAboutDialog(
              context: kNavigatorKey.currentContext!,
              applicationName: kApplicationName,
              applicationVersion: kApplicationVersion,
              applicationIcon: kApplicationIcon,
              children: const [
                Text('This is a simple app to log your conversations.'),
              ],
            );
          },
          icon: const Icon(Icons.info),
          text: const Text('About'),
        ),
      ],
    ),
  ),
];
