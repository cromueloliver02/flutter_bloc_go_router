import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';
import '../configs/configs.dart';
import '../widgets/widgets.dart';
import 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String name = 'home';
  static const String path = name;

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ProductListBloc>(create: (ctx) => sl<ProductListBloc>()),
    BlocProvider<PostListBloc>(create: (ctx) => sl<PostListBloc>()),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _signOut(BuildContext ctx) {
    context.read<AuthBloc>().add(AuthSignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    debugPrint('HOME - AuthBloc $authBloc');

    final ProductListBloc productListBloc = context.read<ProductListBloc>();
    debugPrint('HOME - ProductListBloc $productListBloc');

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('HOME PAGE'),
          actions: [
            IconButton(
              onPressed: () => _signOut(context),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (prev, curr) => prev.user != curr.user,
                    builder: (ctx, state) {
                      if (state.status != AuthStatus.authenticated) {
                        return const SizedBox.shrink();
                      }

                      return Text('Howdy, ${state.user!.name}');
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.goNamed(ProductsPage.name),
                    child: const Text('Go To Products'),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: Future.wait([
                      context.read<ProductListBloc>().loaded,
                      context.read<PostListBloc>().loaded,
                    ]),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      final bool loading =
                          snapshot.connectionState == ConnectionState.waiting;

                      if (loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }

                      return const Column(
                        children: [
                          ProductList(),
                          SizedBox(height: 30),
                          PostList(),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final int userId = context.read<AuthBloc>().state.user!.id;

    context.read<ProductListBloc>().add(ProductListStarted());
    context.read<PostListBloc>().add(PostListStarted(userId: userId));
  }
}
