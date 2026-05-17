enum UserRole { user, company, admin }

UserRole fromJson(String value) {
  return switch (value) {
    "admin" => UserRole.admin,
    "company" => UserRole.company,
    "user" => UserRole.user,
    _ => UserRole.user, // ✅ fallback بدل throw
  };
}
