# desc:
run a android repo sync in a exist source tree

# step:

## first time:
    docker build -t docker-repo-sync .
    docker run -it --name=docker-repo-sync1  -v /PATH_TO_SOURCE:/android docker-repo-sync -c "repo sync -c --no-tags"

## second time:
    docker start docker-repo-sync1
