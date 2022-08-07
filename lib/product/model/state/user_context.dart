// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserContext {
  final String name;

  UserContext(this.name);

  UserContext copyWith({
    String? name,
  }) {
    return UserContext(
      name ?? this.name,
    );
  }
}
