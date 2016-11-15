user = CreateUserService.create_admin_user('fire@kidbombay.com', 'testtest')
user = CreateUserService.create_admin_user('brandon@theswatapp.co', 'testtest')

Race.seed
Gender.seed

Place.import_cities