
From this tutorial:
https://www.youtube.com/watch?v=a-jcTib9ZPA

Made some minor adjustments to the Dockerfile.

To run locally, download the repository and then use the following commands:

docker-compose run app rails new . --force
docker-compose build
docker-compose up -d

View the new Rails app at http://localhost:3001
