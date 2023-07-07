with module authentication
select User { id, email, emailVerified, name, image }
filter .id = <uuid>$id
