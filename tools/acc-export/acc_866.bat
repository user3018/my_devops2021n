@chcp 866

@set RUNNER_ibconnection="/FD:/Anatoly/Bases/АПК"
@set RUNNER_db-user="Администратор"

@call runner run --command "acc.propertiesPaths=D:\Anatoly\repo\devops2021n\tools\acc-export\acc.properties;" --execute "D:\Anatoly\repo\devops2021n\tools\acc-export\acc-export.epf" --ordinaryapp 1
