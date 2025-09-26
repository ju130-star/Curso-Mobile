// Controlador para gerenciar as operações do Firestore relacionadas aos filmes
import 'dart:io';

import 'package:cine_favorite/models/movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MovieFirestoreController {
  // Implementação futura para adicionar, remover e buscar filmes no Firestore
  final _auth =
      FirebaseAuth.instance; //controlador das ações de autenticação do usuário
  final _db = FirebaseFirestore
      .instance; //controlador das ações do banco de dados Firestore

  //método para pegar o usuario logado
  User? get currentUser => _auth.currentUser;

  //método para pegar a coleção de filmes do usuário logado
  //Stream para ouvir mudanças em tempo real
  Stream<List<Movie>> getfavoriteMovies() {
    if (currentUser == null) {
      // Se não houver usuário logado, retorna um stream vazio
      return Stream.value([]); //retorna uma lista vazia
    }
    return _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Movie.fromMap(doc.data())).toList(),
        );
    //retorna a coleção que estava em Json => convertida para Obj de uma Lista de Filmes
  }

  //path e path_provider() para salvar a imagem localmen
  //adicionar filme aos favoritos
  void addFavoriteMovie(Map<String, dynamic> movieData) async {
    //verificar se o filme tem poster
    if (movieData["poster_path"] == null)
      return; //se n tiver poster, n adiciona

    //vou armazenar a capa do filme no dispositivo
    //baixando a imagem da internet
    final imageUrl =
        "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final responseImg = await http.get(Uri.parse(imageUrl));
    //armazenar a imagem no diretotrio do aplicativo
    final imgDir = await getApplicationDocumentsDirectory();
    //baixando a imagem para o aplicativo
    final file = File("${imgDir.path}/${movieData["id"]}.jpg");
    await file.writeAsBytes(responseImg.bodyBytes);

    //criar obj de movies
    final movie = Movie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: file.path.toString(), //caminho local da imagem
    );
    //adicionar o filme no firestore
    await _db
        .collection("usuarios")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(
          movie.id.toString(),
        ) //id do filme como id do doc, crio um objeto com id igual ao id do tmdb
        .set(movie.toMap()); //converte o obj em json para salvar no firestore
  }

  //deleter filme dos favoritos
  void removeFavoriteMovie(int movieId) async {
    await _db.collection("usuarios").doc(currentUser!.uid)
    .collection("favorite_movies").doc(movieId.toString()).delete();
  //deleta o filme da lista de favoritos a partir do id do filme

  // deletar a imagem do filme
  final imagePath = await getApplicationDocumentsDirectory();
  final imageFile = File("${imagePath.path}/$movieId.jpg");
try {
    await imageFile.delete();
} catch (e) {
    print("Erro ao deletar imagem: $e");
  
}
 }

  //update (alterar a nota do filme)
void updateMovieRating(int movieId, double rating) async {
  await _db.collection("usuarios").doc(currentUser!.uid)
  .collection("favorite_movies").doc(movieId.toString())
  .update({"rating": rating});
  Future<void> updateMovieRating(String movieId, double rating) async {
  await FirebaseFirestore.instance
      .collection('movies')
      .doc(movieId)
      .update({'rating': rating});
}

}
}
