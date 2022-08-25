// import 'package:flutter/material.dart';
// import 'package:e_book_example/theme/theme_config.dart';
// import 'package:e_book_example/util/router.dart';
// import 'package:e_book_example/views/downloads/downloads.dart';
// import 'package:e_book_example/views/favorites/favorites.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:provider/provider.dart';
//
// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   List items = [];
//
//   @override
//   void initState() {
//     super.initState();
//     items = [
//       {
//         'icon': Feather.heart,
//         'title': 'Favorites',
//         'function': () => _pushPage(Favorites()),
//       },
//       {
//         'icon': Feather.download,
//         'title': 'Downloads',
//         'function': () => _pushPage(Downloads()),
//       },
//       {
//         'icon': Feather.moon,
//         'title': 'Dark Mode',
//         'function': () => _pushPage(Downloads()),
//       },
//       {
//         'icon': Feather.info,
//         'title': 'About',
//         'function': () => showAbout(),
//       },
//       {
//         'icon': Feather.file_text,
//         'title': 'Licenses',
//         'function': () => _pushPageDialog(LicensePage()),
//       },
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Remove Dark Switch if Device has Dark mode enabled
//     if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
//       items.removeWhere((item) => item['title'] == 'Dark Mode');
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Profiles'),
//       ),
//       body: ListView.separated(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: items.length,
//         itemBuilder: (BuildContext context, int index) {
//           if (items[index]['title'] == 'Dark Mode') {
//             return _buildThemeSwitch(items[index]);
//           }
//
//           return ListTile(
//             onTap: items[index]['function'],
//             leading: Icon(
//               items[index]['icon'],
//             ),
//             title: Text(
//               items[index]['title'],
//             ),
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return Divider();
//         },
//       ),
//     );
//   }
//
//   Widget _buildThemeSwitch(Map item) {
//     return SwitchListTile(
//       secondary: Icon(
//         item['icon'],
//       ),
//       title: Text(
//         item['title'],
//       ),
//       value:
//           true, // Provider.of<AppProvider>(context).theme == ThemeConfig.lightTheme
//               // ? false
//               // : true,
//       onChanged: (v) {
//         if (v) {
//           // Provider.of<AppProvider>(context, listen: false)
//           //     .setTheme(ThemeConfig.darkTheme, 'dark');
//         } else {
//           // Provider.of<AppProvider>(context, listen: false)
//           //     .setTheme(ThemeConfig.lightTheme, 'light');
//         }
//       },
//     );
//   }
//
//   _pushPage(Widget page) {
//     MyRouter.pushPage(context, page);
//   }
//
//   _pushPageDialog(Widget page) {
//     MyRouter.pushPageDialog(context, page);
//   }
//
//   showAbout() {
//     showDialog(
//       context: context,
//       builder: (_) {
//         return AlertDialog(
//           title: Text(
//             'About',
//           ),
//           content: Text(
//             'Simple eBook app by JideGuru',
//           ),
//           actions: <Widget>[
//             ElevatedButton(
//               // textColor: Theme.of(context).colorScheme.secondary,
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 'Close',
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../util/router.dart';
import '../downloads/downloads.dart';
import '../favorites/favorites.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List items = [];
  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Feather.heart,
        'title': 'Favorites',
        'function': () => _pushPage(Favorites()),
      },
      {
        'icon': Feather.download,
        'title': 'Downloads',
        'function': () => _pushPage(Downloads()),
      },
      {
        'icon': Feather.moon,
        'title': 'Dark Mode',
        'function': () => _pushPage(Downloads()),
      },
      {
        'icon': Feather.info,
        'title': 'About',
        'function': () => showAbout(),
      },
      {
        'icon': Feather.file_text,
        'title': 'Licenses',
        'function': () => _pushPageDialog(LicensePage()),
      },
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          if (items[index]['title'] == 'Dark Mode') {
            return _buildThemeSwitch(items[index]);
          }

          return ListTile(
            onTap: items[index]['function'],
            leading: Icon(
              items[index]['icon'],
            ),
            title: Text(
              items[index]['title'],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }

  Widget _buildThemeSwitch(Map item) {
    return SwitchListTile(
      secondary: Icon(
        item['icon'],
      ),
      title: Text(
        item['title'],
      ),
      value: true,
      // Provider.of<AppProvider>(context).theme == ThemeConfig.lightTheme
      //     ? false
      //     : true,
      onChanged: (v) {
        if (v) {
          // Provider.of<AppProvider>(context, listen: false)
          //     .setTheme(ThemeConfig.darkTheme, 'dark');
        } else {
          // Provider.of<AppProvider>(context, listen: false)
          //     .setTheme(ThemeConfig.lightTheme, 'light');
        }
      },
    );
  }
  _pushPage(Widget page) {
    MyRouter.pushPage(context, page);
  }

  _pushPageDialog(Widget page) {
    MyRouter.pushPageDialog(context, page);
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'About',
          ),
          content: Text(
            'Simple eBook app by JideGuru',
          ),
          actions: <Widget>[
            ElevatedButton(
              // textColor: Theme.of(context).colorScheme.secondary,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}
