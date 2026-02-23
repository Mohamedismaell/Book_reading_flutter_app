enum Profile {
  accountSecurity('Account Security'),
  // changePassword('Change Password'),
  appTheme('App Theme'),
  language('Language');
  // signOut('Log Out');

  final String value;
  const Profile(this.value);
}

enum ImageOptions { camera, gallery }
