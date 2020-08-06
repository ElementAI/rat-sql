IMAGE=volatile-images.borgy.elementai.net/dzmitry/ratsql

CMD="cd $PWD; $@"

NV_GPU=2 nvidia-docker run --name ratsql --user '12078' --rm -it\
    -e PYTHONPATH=/app/third_party/wikisql\
    -v /home/$USER/data:/home/$USER/data\
    -v /home/$USER/dist:/home/$USER/dist\
    -v /home/$USER/stanza_resources:/home/$USER/stanza_resources\
    -v /home/$USER/.cache:/home/$USER/.cache\
    -v /mnt/scratch:/mnt/scratch\
    -v /mnt/scratch/nl2sql/unirat-experiments:/logdir\
    -v /etc/group:/etc/group:ro\
    -v /etc/passwd:/etc/passwd:ro\
    -v /etc/shadow:/etc/shadow:ro\
    $IMAGE bash -c "$CMD"
