enum Profile {
  notifications('Notifications'),
  language(
    'Language',
  ),
  changePassword('Change Password'),
  education('Education'),
  privacy('Privacy'),
  termsAndConditions('Terms & Conditions'),
  signOut('Sign Out');

  final String value;
  const Profile(this.value);
}

enum ImageOptions { camera, gallery }
