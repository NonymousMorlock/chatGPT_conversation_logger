import 'package:conversation_log/core/common/settings/cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_bar/menu_bar.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

final kMenuButtons = [
  BarButton(
    text: const Text('File', style: TextStyle(color: Colors.white)),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          onTap: () {},
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
          onTap: () {},
          text: const Text('Open File'),
        ),
        MenuButton(
          onTap: () {},
          text: const Text('Open Folder'),
        ),
        const MenuDivider(),
        MenuButton(
          text: const Text('Preferences'),
          onTap: () {},
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
                onTap: () {},
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
        MenuButton(
          onTap: () {},
          shortcutText: 'Ctrl+Q',
          text: const Text('Exit'),
          icon: const Icon(Icons.exit_to_app),
        ),
      ],
    ),
  ),
  BarButton(
    text: const Text(
      'Edit',
      style: TextStyle(color: Colors.white),
    ),
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
  BarButton(
    text: const Text(
      'Help',
      style: TextStyle(color: Colors.white),
    ),
    submenu: SubMenu(
      menuItems: [
        MenuButton(
          onTap: () {},
          text: const Text('Check for updates'),
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {},
          text: const Text('View License'),
        ),
        const MenuDivider(),
        MenuButton(
          onTap: () {},
          icon: const Icon(Icons.info),
          text: const Text('About'),
        ),
      ],
    ),
  ),
];
