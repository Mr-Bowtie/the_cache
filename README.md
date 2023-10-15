# The Cache wiki

## Main tech
  - [Sinatra](https://sinatrarb.com/)
  - [Bulma](https://bulma.io/)
  - [TinyMCE](https://www.tiny.cloud/)

## Deployment
  - Deployed on [Fly.io](https://fly.io)

## Local Development
  - uses a dockerfile to mimic deployed environment
  - startup by running `bin/run -d`
  - connect on `localhost:9090`
  - can run locally without docker by running: `bundle exec rackup`
    - will require setting up ruby and running `bundle install` from project root
  - *NOTE* this app uses no database, rather just reads and writes text files to the server disk

## Roadmap
  - image uploads
  - automatic file backups
  - cooler design
  - form validations
  - GHA CI auto-deploy pipeline
  - edit & delete records
