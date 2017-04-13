
# export current user id
export USER_ID=$(id -u -r)

# change shell appearance to notify user he can use tools
PS1="\[\e[1;31m\](domine)\[\e[0m\] $PS1"

composer() {
   docker run -u $USER_ID -it --rm -v $(pwd):/app -v ~/.composer/cache:/composer/cache composer/composer $@
}

php() {
  docker exec -it dominenv_app php $@
}

alias artisan="php artisan"

export -f composer
export -f php

if [ ! -d $PWD/app ]; then
  ./setup
fi

docker-compose stop
docker-compose rm --force
docker-compose up -d

echo "Ready to go on localhost:8080 - Have fun!"
