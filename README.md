# Lane Breach API
## Development

### Prerequisites

* [Docker](https://www.docker.com/)
* [yarn](https://yarnpkg.com/en/) (to provide simple command aliases for lengthy docker commands)

### Getting Started

Run `yarn build` to build and `yarn start` at the command line to run the API locally. Be sure you have the Docker agent running.

You'll also need to create the database tables the application depends on and seed them with data `yarn db:reset`.

Finally, make an API request to see if your environment is configured correctly. See [the documentation](https://github.com/lanebreach/lanebreach-api/blob/master/docs.md) if you're looking for a sample request.

## Database

The API is currently backed by a [PostgreSQL](https://www.postgresql.org/) database with the [PostGIS extension](https://postgis.net/).

### Data sources

Most of our data comes from [Open Data SF](https://datasf.org/opendata/). See `db/seeds.rb` and
`Dockerfile.db` for further details. The specific Sf 311 case data comes from https://data.sfgov.org/City-Infrastructure/311-Cases/vw6y-z8j6.

### Local DB

You can connect to the local Postgres instance by running `yarn db` at the command line.

### Production DB

Our production DB is currently hosted on [AWS (RDS)](https://aws.amazon.com/rds/). Use the following command to connect to it:
```
PGPASSWORD=<<PASSWORD>> psql bikelane bikelanes --host bikelanes.cl6adk7d8ywn.us-east-1.rds.amazonaws.com
```

Check your Heroku account to retrieve the password or talk to a maintainer.

## Deployment

The app lives on [Heroku](https://www.heroku.com/) at https://lane-breach.herokuapp.com/ which you must be logged into to deploy. Make sure to add the heroku remote using `heroku git:remote -a lane-breach`.

You can push a new version of the app by running `git push -f heroku master`. See the [Git deployment documentation](https://devcenter.heroku.com/articles/git) for further details.

You can run database migrations by running `heroku run rails db:migrate`. You only need to run migrations if you've added a new [database migration](https://edgeguides.rubyonrails.org/active_record_migrations.html).

## Contributing

We welcome contributions! All of our contributors are expected to follow the rules outlined in our Code of Conduct. Please create a separate pull request against master for each new feature/bug-fix. We will try to use Github issues whenever possible to describe tasks that we need to do.

Steps for building the various apps, and an overview of the design can be found on the wiki. We're excited to see your PRs!
