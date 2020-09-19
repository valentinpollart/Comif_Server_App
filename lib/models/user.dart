class User {

  final int id;
  final String status;
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final int balance;
  final int promotionId;
  int expensesDay;
  int expensesWeek;
  int expensesMonth;

  User({this.id, this.status, this.firstName, this.lastName, this.email, this.token, this.balance, this.promotionId, this.expensesDay, this.expensesWeek, this.expensesMonth});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      status: json['status'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      token: json['token'] as String,
      balance: json['balance'] as int,
      promotionId: json['promotionId'] as int,
    );
  }
}