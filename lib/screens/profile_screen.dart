import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_finance_tracker/blocs/user/user_event.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_state.dart';
import '../widgets/bottom_navbar_widget.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserFetch());
  }

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserFailure) {
                  return const Center(
                    child:
                        Text('Error loading user data, please try again later'),
                  );
                }

                if (state is UserLoaded) {
                  final user = state.user;

                  return Column(
                    children: [
                      const SizedBox(height: 80),
                      CircleAvatar(
                        radius: 60,
                        foregroundImage: NetworkImage(
                          user.avatar.isEmpty
                              ? 'https://picsum.photos/200'
                              : user.avatar,
                        ),
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: Text(
                          user.name.isEmpty ? 'user@${user.id}.' : user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: const TextStyle(
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
                  );
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavbarWidget(),
      ),
    );
  }
}
