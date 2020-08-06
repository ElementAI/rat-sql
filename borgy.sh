IMAGE=volatile-images.borgy.elementai.net/dzmitry/ratsql

CMD="cd $PWD; $@"

borgy submit --name ratsql\
    -e PYTHONPATH=/app/third_party/wikisql\
    -v /home/$USER/data:/home/$USER/data\
    -v /home/$USER/dist:/home/$USER/dist\
    -v /home/$USER/stanza_resources:/home/$USER/stanza_resources\
    -v /home/$USER/.cache:/home/$USER/.cache\
    -v /mnt/scratch:/mnt/scratch\
    -v /mnt/scratch/nl2sql/unirat-experiments:/logdir\
    --restartable\
    --cpu 8 --gpu 1 --mem 16 --gpu-mem 32\
    -i $IMAGE\
    -- bash -c "$CMD"
