import 'package:bloc_clean_code/bloc/movie/movie_bloc.dart';
import 'package:bloc_clean_code/config/components/internet_exception_widget.dart';
import 'package:bloc_clean_code/config/routes/routes.dart';
import 'package:bloc_clean_code/main.dart';
import 'package:bloc_clean_code/service/storage/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/api_status.dart';
import '../../utils/flushbar_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _movieBloc = MovieBloc(movieRepository: getIt());
  }

  // @override
  // void dispose() {
  //   _movieBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: [
            IconButton(
              onPressed: () {
                LocalStorage localStorage = LocalStorage();
                localStorage.deleteValue('token').then((value) {
                  localStorage.deleteValue('isLogin').then((value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutesName.loginScreen, (route) => false);
                  });
                });
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocProvider(
          create: (_) => _movieBloc..add(MoviesFetch()),
          child: BlocBuilder<MovieBloc, MovieState>(
            buildWhen: (previous, current) =>
                previous.movieList != current.movieList,
            builder: (BuildContext context, state) {
              switch (state.movieList.status) {
                case Status.loading:
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 5),
                        Text('Loading...')
                      ],
                    ),
                  );
                case Status.error:
                  if (state.movieList.message!.contains("No Internet Connections: null")) {
                    return InternetExceptionWidget(onPress: () {
                      _movieBloc.add(MoviesFetch());
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (kDebugMode) {
                        print('Result: ${state.movieList.message}');
                      }
                      ExtensionFlushBarHelper.flushBarErrorMessage(
                          state.movieList.message.toString(), context);
                    });
                    return SizedBox();
                  }

                case Status.completed:
                  if (state.movieList.data == null) {
                    return Center(child: Text("No data found!"));
                  } else {
                    final moviesList = state.movieList.data!;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView.builder(
                        itemCount: moviesList.tv_shows.length,
                        itemBuilder: (context, index) {
                          final tvShow = moviesList.tv_shows[index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                tvShow.image_thumbnail_path.toString(),
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                              title: Text(tvShow.name.toString()),
                              subtitle: Text(tvShow.network.toString()),
                              trailing: Text(tvShow.status.toString()),
                            ),
                          );
                        },
                      ),
                    );
                  }
                default:
                  return const SizedBox();
              }
            },
          ),
        ));
  }
}
