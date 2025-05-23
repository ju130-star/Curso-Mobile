import '../models/pet_model.dart';
import '../services/pathshop_dbhelper.dart';

class PetController {
  final PetShopDBHelper _dbHelper = PetShoprDBHelper();

  //métodos controllers

  Future<int> cretePet(Pet pet) async {
    return _dbHelper.insertPet(pet);
  }

  Future<List<Pet>> readPets() async {
    return _dbHelper.getPets();
  }

  Future<Pet?> readPetById(int id) async {
    return _dbHelper.getPetById(id);
  }

  Future<int> deletePet(int id) async {
    return _dbHelper.deletePet(id);
  }
}
