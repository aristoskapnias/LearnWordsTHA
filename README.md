### LearnWords Take Home Assignment project

## SCOPE

Demo project to imitate a realistic, hands-on problem reflecting the kind of work of a LearnWords Analytics Engineer

## ASSUMPTIONS

- DBT project was created in local Windows WSL (Ubuntu 24.04.3 LTS) in newly created Python virtual environment just for this
- Materialization of layers and final Mart table took place in pre-existing local Postgres running on port 5432.
Database used called 'LearnWords'. Other RDBMS are easily supported by downloading respective adapter and setting the profile appropriately in profiles.yml
- Docker container running Postgres or instructions to create 1 for test purposes not included as is out of scope of this demo
- Time limitations applied
- Project was structured in a way to support regular runs with seeds including new and updated records for entities (invoices, subscriptions etc.) included. It does not support SCD though, as this would be out of scope of this demo
- For Mart table least analysis dimensions were included, though many more could be added depending on the requirements

## STEPS

- Download project from Git repo in home folder (mine is /home/aristos/)
git clone git@github.com:aristoskapnias/LearnWordsTHA.git LearnWordsTHA

- Create .dbt folder to hold profiles.yml
mkdir .dbt

- Copy profiles.yml from project folder to .dbt folder
cp LearnWordsTHA/profiles.yml .dbt/

- Create Python virtual environment with dependencies to run project
python3 -m venv DBTenv
source DBTenv/bin/activate
pip install dbt-core==1.11.9 # versions found to be compatible
pip install dbt-postgres==1.10.0

cd LearnWordsTHA

- Run dbt seed to load .csv files as raw tables in db
dbt seed

images/dbt_seed.png

- Run tests to check data quality. Records failing will be written to a separate schema in db set via 
 dbt_project.yml

dbt test

-- Run project to load data in final Mart table
dbt run
