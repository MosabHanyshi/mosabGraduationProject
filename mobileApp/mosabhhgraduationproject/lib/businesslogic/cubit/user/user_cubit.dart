import 'package:bloc/bloc.dart';
import 'package:mosabhhgraduationproject/auth/Auth.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/user_repo.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';

class UserCubit extends Cubit<GeneralState<User>> {
  UserCubit(this.userRepo) : super(InitialState());
  final UserRepo userRepo;
  final SharedP sharedP = SharedP();
  final Auth firebaseAuth = Auth();

  void getCurrentUser(String email, String pass) async {
    emit(LoadingState());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: pass);
    } catch (firebaseError) {}
    userRepo.getCurrentUser(email, pass).then((user) {
      if (user == null) {
        emit(EmptyState());
      } else {
        emit(LoadedState(user));
        sharedP.saveUser(user);
      }
    }, onError: (error) {
      emit(ErrorState("sth went wrong"));
    });
  }

  Future<void> addUser(User user) async {
    await userRepo.addUser(user);
    if (user.pass != null && user.email != null) {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: user.email!, password: user.pass!);
      } catch (error) {
        emit(ErrorState("sth went wrong"));
      }
    }
  }

  void updateUserInfo(User user) {
    userRepo
        .updateUserInfo(user)
        .then((value) => {sharedP.saveUser(user)}, onError: (error) {});
  }

  void updateUserPass(int id, String pass) {
    userRepo
        .updateUserPass(id, pass)
        .then((value) => {sharedP.updatePass(pass)}, onError: (error) {});
  }
}
