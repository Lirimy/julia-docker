# julia-docker

```
docker build -t lirimy/jupyter:0.6.3 .
docker run -d -p 8888:8888 --name myjulia -v "$PWD":/home/jovyan/work --user root -e GRANT_SUDO=yes lirimy/jupyter:0.6.3 start-notebook.sh
docker exec -it --user jovyan myjulia bash

$ jupyter notebook list # check token
```
