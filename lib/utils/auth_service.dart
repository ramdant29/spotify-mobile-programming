class UserAccount {
  final String name;
  final String email;
  final String password;

  UserAccount({required this.name, required this.email, required this.password});
}

class AuthService {
  static List<UserAccount> registeredUsers = [];
  static UserAccount? loggedInUser;
}