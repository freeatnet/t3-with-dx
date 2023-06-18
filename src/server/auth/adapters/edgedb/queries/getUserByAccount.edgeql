with module authentication
select assert_single(
  (
    select User { id, email, emailVerified, name, image }
    filter .accounts.provider = <str>$provider
      and .accounts.providerAccountId = <str>$providerAccountId
  ),
  message := "found more than one user with the same account"
)
