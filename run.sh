docker run -it --gpus all -v $(pwd):/lab --net=host nblab /bin/bash -c "(ls /lab/requirements.txt >> /dev/null 2>&1 && pip install -r /lab/requirements.txt) || echo 'No requirements.txt'; nohup jupyter notebook > /var/log/jupyter.log & >> disown; /bin/zsh"
