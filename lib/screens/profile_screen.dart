import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/bottom_navbar_widget.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            LoginScreen.routeName,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage('https://picsum.photos/200'),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'Alastier Catayoc',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'email@email.com',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: () {
                  context.read<AuthBloc>().add(LoggedOut());
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
                icon: const Icon(Icons.logout_rounded),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavbarWidget(),
      ),
    );
  }
}
