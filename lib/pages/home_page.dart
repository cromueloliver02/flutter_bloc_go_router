import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/blocs.dart';
import '../configs/configs.dart';
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
        body: SafeArea(
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
                  // Expanded(
                  //   child: BlocBuilder<ProductListBloc, ProductListState>(
                  //     buildWhen: (prev, curr) => prev.status != curr.status,
                  //     builder: (ctx, state) {
                  //       if (state.status == ProductListStatus.initial) {
                  //         return const SizedBox.shrink();
                  //       }

                  //       if (state.status == ProductListStatus.loading) {
                  //         return const Center(
                  //             child: CircularProgressIndicator());
                  //       }

                  //       if (state.status == ProductListStatus.failure) {
                  //         return const Center(
                  //           child: Text('Something went wrong'),
                  //         );
                  //       }

                  //       if (state.productList.isEmpty) {
                  //         return const Center(
                  //             child: Text('No Products to Show'));
                  //       }

                  //       return ProductList(products: state.productList);
                  //     },
                  //   ),
                  // ),
                  Expanded(
                    child: FutureBuilder(
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

                        // return ProductList(products: state.productList);
                        return const Text('TEST');
                      },
                    ),
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
    context.read<ProductListBloc>().add(ProductListStarted());
    // context.read<PostListBloc>().add(PostListStarted(userId: ));
  }

  @override
  void dispose() {
    // TODO: refactor
    sl.resetLazySingleton(instance: sl<ProductListBloc>());
    super.dispose();
  }
}
