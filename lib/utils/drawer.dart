import 'package:flutter/material.dart';


class TeacherDrawerWidget extends StatefulWidget {
  const TeacherDrawerWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<TeacherDrawerWidget> createState() => _TeacherDrawerWidgetState();
}

class _TeacherDrawerWidgetState extends State<TeacherDrawerWidget> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.infinity,
              height: widget.height * 0.3,
              // child: Image.asset(
              //   AssetPaths.splashimage,
              //   fit: BoxFit.cover,
              // ),
            ),
            // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (BuildContext context, ThemeState state) {
            //     return ListTile(
            //       onTap: () {
            //         Navigator.pop(context);
            //         // Navigator.push(context, MaterialPageRoute(builder: (_){
            //         //   return DriverUpdateRegistrationDashboard();
            //         // }));
            //       },
            //       leading: Icon(state.themeMode == ThemeModeEnum.light
            //           ?  Icons.person
            //           :   Icons.person_2_outlined),
            //       title: const Text(
            //         'Profile',
            //       ),
            //     );
            //   },
            // ),
            // // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (BuildContext context, state) {
            //     return ListTile(
            //       onTap: () {
            //         Navigator.pop(context);
            //         // Navigator.pushNamed(context, RoutesName.updatePasswordForPassenger);
            //       },
            //       leading: Icon(state.themeMode == ThemeModeEnum.light
            //           ? Icons.lock_clock  
            //           : Icons.lock_clock_outlined),
            //       title: const Text(
            //         'Change Password',
                  
            //       ),
            //     );
            //   },
            // ),
            // // InkWell(
            //   onTap: () {},
            //   child: const ListTile(
            //     leading: Icon(Icons.wallet, color: Themecolor.primary),
            //     title: Text(
            //       'Wallet',
            //     ),
            //   ),
            // ),
            // ListTile(
            //   leading: const Icon(Icons.history, color: Themecolor.primary),
            //   title: const Text(
            //     'History',
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // // ),
            // BlocBuilder<ThemeBloc, ThemeState>(
            //   builder: (BuildContext context, ThemeState state) {
            //     return InkWell(
            //       onTap: () {
            //         Navigator.pushNamed(
            //             context, RoutesName.themeSettingForTeacher);
            //       },
            //       child: ListTile(
            //         leading: Icon(state.themeMode == ThemeModeEnum.light
            //             ? Icons.dark_mode_rounded
            //             : Icons.light_mode_outlined),
            //         title: Text('dark Mode'),
            //         // trailing: Switch(
            //         //   value: state.isDarkOrLight,
            //         //   onChanged: (newValue) {
            //         //     context.read<ThemeBloc>().add(IsDarkOrLightMode());
            //         //   },
            //         // ),
            //       ),
            //     );
            //   },
            // ),
            // Expanded(
            //   child: SizedBox(height: widget.height * 0.23),
            // ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFFFF0000)),
                title: const Text(
                  'Logout',
                ),
                onTap: () {
                  // SessionHandling().removeEverything();
                  // Navigator.pushReplacementNamed(
                  //     context, RoutesName.loginScreen);
                }),
          ],
        ),
      ),
    );
  }
}
