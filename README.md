## Docker setup for jupyter notebook classic and some essential extensions

### Make sure you add `export DOCKER_BUILDKIT=1` to you `~/.bashrc`

To build the image run `docker build -t nblab https://l.stm.ai/build`
You have two options here, to specify the notebook port and the starting docker image. You can change these settings with the following:
- Change the base image: `docker build -t nblab --build-arg BASE=nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04 https://l.stm.ai/build`
- Change the notebook port: `docker build -t --build-arg PORT=9999 nblab https://l.stm.ai/build`
- Change both: `docker build -t nblab --build-arg BASE=nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04 --build-arg PORT=9999 https://l.stm.ai/build`

After the image is built, go to your project's folder and run `bash <(curl -L https://l.stm.ai/rund)`
This will run the image named `nblab` and install all the specified packages in `requirements.txt` from your current work folder.
It will also make availabe everything from your current folder inside the container.
You can access the notebook instance in a browser at [http://0.0.0.0:8888](http://0.0.0.0:8888) or a different port if you changed it.