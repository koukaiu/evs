#!/usr/bin/env bash
# author: Kaiyu Huang
# time: 2022/05
# version: 1.0

export SEED=222
export CHECKPOINT_PATH=''
export DATA_PATH=''
export ARCH=transformer
export TASK=translation_multi_simple_epoch
export LANG_DICT=''
export lang_pairs=cs-en,de-en,fi-en,fr-en,hi-en,lt-en,lv-en,ru-en,ro-en,tr-en,zh-en,es-en,et-en,ha-en,pl-en,ps-en,ja-en,ta-en,km-en,is-en

export CLIP_NORM=0.0
export OPTIMIZER=adam
export ADAM_EPS=1e-9
export LR=5e-4
export LR_SCHEDULER=inverse_sqrt
export WARMUP=8000
export DROPOUT=0.2
export ATT_DROPOUT=0.2
export WEIGHT_DECAY=0.0001
export CRITERION=label_smoothed_cross_entropy
export LABEL_SMOOTHING=0.1
export MAX_TOKENS=4096

export UPDATE_FREQ=4
export SAVE_INTERVAL_UPDATES=2500
export KEEP_INTERVAL_UPDATES=10
export MAX_UPDATE=500000


fairseq-train $DATA_PATH \
  --share-all-embeddings \
  --encoder-normalize-before --decoder-normalize-before \
  --encoder-embed-dim 1024 --encoder-ffn-embed-dim 4096 --encoder-attention-heads 16 \
  --decoder-embed-dim 1024 --decoder-ffn-embed-dim 4096 --decoder-attention-heads 16 \
  --encoder-layers 6 --decoder-layers 6 \
  --left-pad-source False --left-pad-target False \
  --arch $ARCH \
  --task $TASK \
  --sampling-method temperature \
  --sampling-temperature 5 \
  --lang-tok-style multilingual \
  --lang-dict $LANG_DICT \
  --lang-pairs $lang_pairs\
  --encoder-langtok src \
  --decoder-langtok \
  --clip-norm $CLIP_NORM \
  --optimizer $OPTIMIZER \
  --adam-betas '(0.9, 0.98)' \
  --adam-eps $ADAM_EPS \
  --lr $LR \
  --lr-scheduler $LR_SCHEDULER \
  --warmup-updates $WARMUP \
  --dropout $DROPOUT \
  --attention-dropout $ATT_DROPOUT \
  --weight-decay $WEIGHT_DECAY \
  --criterion $CRITERION \
  --label-smoothing $LABEL_SMOOTHING \
  --max-tokens $MAX_TOKENS \
  --save-dir $CHECKPOINT_PATH/checkpoints/ \
  --update-freq $UPDATE_FREQ \
  --save-interval-updates $SAVE_INTERVAL_UPDATES \
  --keep-interval-updates $KEEP_INTERVAL_UPDATES \
  --max-update $MAX_UPDATE \
  --no-epoch-checkpoints \
  --seed $SEED --log-format simple --log-interval 500 \
  --patience 15 \
  --fp16 \
  --tensorboard-logdir $CHECKPOINT_PATH/logs/ \
  --no-progress-bar \
  --ddp-backend no_c10d
  