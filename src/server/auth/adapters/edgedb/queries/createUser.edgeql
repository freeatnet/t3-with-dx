with
  module authentication,
  inserted := (
    insert User {
      email := <str>$email,
      emailVerified := <optional datetime>$emailVerified,
      name := <optional str>$name,
      image := <optional str>$image,
    }
  )
select inserted { id, email, emailVerified, name, image }
