with
  module authentication,
  updated := (
    update User
    filter .id = <uuid>$id
    set {
      email := <optional str>$email,
      emailVerified := <optional datetime>$emailVerified,
      name := <optional str>$name,
      image := <optional str>$image,
      updatedAt := datetime_of_statement(),
    }
  )
select updated { id, email, emailVerified, name, image }
