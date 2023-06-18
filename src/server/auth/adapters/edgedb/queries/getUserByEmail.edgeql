with module authentication
select assert_single(
  (
    select User { id, email, emailVerified, name, image }
    filter .email = <str>$email
  ),
  message := "found more than one user with the same email"
)
