### Using the starter project

python3 -m venv DBTenv
source DBTenv/bin/activate
pip install dbt-core==1.11.9
pip install dbt-postgres==1.10.0

dbt init DBTproject

mkdir .dbt
touch profiles.yml

postgres_localhost:
  outputs:
    dev:
      type: postgres
      host: 127.0.0.1
      port: 5432
      user: "superuser"
      password: "superuser"
      dbname: "LearnWords"
      schema: "public"
      threads: 5 # 1 for each model running concurrently
  target: dev

dbt seed