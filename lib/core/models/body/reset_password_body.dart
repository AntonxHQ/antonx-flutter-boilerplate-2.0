class ResetPasswordBody {
  String? email;

  ResetPasswordBody({
    this.email,
  });

  toJson() => {
        'email': this.email,
      };
}
