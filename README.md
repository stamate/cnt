## Docker setup for jupyter notebook classic and some essential extensions

### Make sure you add `export DOCKER_BUILDKIT=1` to your `~/.bashrc`

To build the image run `docker build -t nblab https://l.stm.ai/build`
You can also specify a different base image by passing `--build-arg BASE=`:
- Change the base image: `docker build -t nblab --build-arg BASE=nvidia/cuda:11.7.1-cudnn8-devel-ubuntu20.04 https://l.stm.ai/build`

After the image is built, go to your project's folder and run `bash <(curl -L https://l.stm.ai/run)`
This will run the image named `nblab` and install all the specified packages in `requirements.txt` from your current folder.
It will also make availabe everything from your current folder inside the container.
You can access the notebook instance in a browser at [http://0.0.0.0:8899](http://0.0.0.0:8899) (or a different port if you changed it). The password is `q1w2e3`!
To let the container run in the background and get back to your shell press `CTRL+P`, `CTRL+Q`.

Have fun!!
