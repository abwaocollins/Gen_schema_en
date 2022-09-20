alias GenSchemaEn.{Invite, Repo, User, Permission, Role, UserTeam}

create_invite = Permission.changeset(%Permission{}, %{
  name: "create an Invite",
  description: "Create an invite to users to join the teams "
})
|>Repo.insert!()


create_project = Permission.changeset(%Permission{}, %{
  name: "Create a Project",
  description: "User can create projects inside a team"
})
|>Repo.insert!()

admin = Role.changeset(%Role{}, %{
  name: "Admin",
  description: "Allow user to do everything"
})
|>Repo.insert!()
|> Repo.preload(:permissions)

moderator = Role.changeset(%Role{}, %{
  name: "Moderator",
  description: "Allow users to create projects "
})
|> Repo.insert!()
|> Repo.preload(:permissions)

visitor = Role.changeset(%Role{}, %{
  name: "Visitor",
  description: "User can do nothing"
})
|> Repo.insert!()


moderator
|> Role.insert_permissions([create_invite, create_project])
|> Repo.update!()

admin
|> Role.insert_permissions([create_project])
|> Repo.update!()


Repo.all(Role)
|> Repo.preload(:permissions)
|> IO.inspect()




user = %{
          email: "abwaocollins060@gmail.com",
          first_name: "Collins",
          lastname: "Abwao",
          teams: [%{
            name: "Elxpro",
            projects: [%{title: "React"}, %{title: "Node"}]},
          %{name: "SupervisorsChildren", projects: [%{title: "Mongo"}, %{title: "Sql"}]}]
        }
user = User.changeset(%User{}, user)
|> Repo.insert!()
|> Repo.preload(teams: [:projects], userteams: [])
|> IO.inspect()


[team | _] = user.teams

Invite.changeset(%Invite{}, %{email: "test@test", user_id: user.id, team_id: team.id})
|> Repo.insert!()
|> IO.inspect()


user
|> User.user_belongs_teams(user.teams)
|> Repo.update!()
|> IO.inspect()

test = User.changeset(%User{}, %{
          email: "ab@gmail.com",
          first_name: "lins",
          lastname: "wao" })
      |> Repo.insert!()

test
|> Repo.preload(:userteams)
|> User.user_belongs_teams([team])
|> Repo.update!()
|> IO.inspect()


[user_t1|_] = Repo.all(UserTeam)
              |>IO.inspect()

[role1|_] = Repo.all(Role)
            |>IO.inspect()
