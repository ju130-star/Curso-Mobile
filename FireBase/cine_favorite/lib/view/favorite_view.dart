import 'dart:io';

import 'package:cine_favorite/controllers/movie_firestore_controller.dart';
import 'package:cine_favorite/models/movie.dart';
import 'package:cine_favorite/view/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
//atributo
final _movieFirestoreController = MovieFirestoreController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      // ...existing code or body...
      //criar um gridview para mostrar os filmes favoritos
      body: StreamBuilder<List<Movie>>(
        stream: _movieFirestoreController.getfavoriteMovies(),
       builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Center(child: Text('Erro ao carregar lista dos filmes favoritos'));
        }
        //emquanto carrega a lista
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(),);
        }
        //quando a lista esta vazia
        if(snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum filme adicionado aos favoritos'));
        }
        //Construção da lista
        final favoriteMovies = snapshot.data!;
        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: favoriteMovies.length,
          itemBuilder: (context, index){
            //cria um objeto de movie
            final movie = favoriteMovies[index];
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
  onLongPress: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover favorito'),
        content: Text('Deseja remover este filme dos favoritos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Remover'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _movieFirestoreController.removeFavoriteMovie(movie.id);
    }
  },
  child: Image.file(
    File(movie.posterPath),
    fit: BoxFit.cover,
  ),
),
                  
                  //GestureDetector(
                  //onLongPress: () async {
                    //colocar um alert de confirmação
                   // _movieFirestoreController.removeFavoriteMovie(movie.id);
                 // },
                 // child: Image.file(
                  //  File(movie.posterPath),
                   // fit: BoxFit.cover,
                //  ),
                 // ),
                  //titulo do filme
                  Padding(padding: EdgeInsets.all(8),
                  child: Text(movie.title),),


                  Padding(
  padding: EdgeInsets.all(8),
  child: RatingBar.builder(
    initialRating: movie.rating.toDouble(), // valor inicial
    minRating: 1,
    direction: Axis.horizontal,
    allowHalfRating: true, // permite meio ponto (ex: 3.5)
    itemCount: 5,
    itemSize: 20,
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) async {
      // salva a avaliação no Firestore
     _movieFirestoreController.updateMovieRating(movie.id, rating);

      // feedback visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Você avaliou '${movie.title}' com $rating estrelas"),
        ),
      );
    },
  ),
),
            

                ],
              ),
            );
          });
       }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchMovieView())),
          child: Icon(Icons.search),),
          
    );
  }
}