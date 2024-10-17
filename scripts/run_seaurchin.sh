ROOT_DIR=$(dirname $(dirname "$(readlink -f "$0")"))'/'
MODEL_DIR=$ROOT_DIR'models'
THIS_FILE=$(basename "$0")
TIMESTAMP=$(date +"-%Y-%m-%d-%H-%M-%S")

CONFIG_DIR=$ROOT_DIR'configs/curv_recon_seaurchin.toml' # change to your config file path
IDENTIFIER='spin_seaurchin'                                                   # change to your desired identifier
LOG_DIR='./log/2d_curv/'                                           # change to your desired log path
EXP_DIR=$LOG_DIR$IDENTIFIER$TIMESTAMP/
mkdir -p $EXP_DIR
cp -r scripts/$THIS_FILE $EXP_DIR # Copy this script to the experiment directory
cp -r $CONFIG_DIR $EXP_DIR        # Copy the config file to the experiment directory

for SHAPE_TYPE in  'seaurchin'; do # for SHAPE_TYPE in 'circle' 'L' 'square' 'snowflake' 'starhex' 'button' 'target' 'bearing' 'snake' 'seaurchin' 'peace' 'boomerangs' 'fragments' 'house'; do
    echo "Run script for shape \"$SHAPE_TYPE\""
    SAVED_MODEL_DIR=$EXP_DIR/$SHAPE_TYPE/trained_models # Change to your desired svaed model path, if evaluation is needed
    python3 train/train.py --config $CONFIG_DIR --log_dir $EXP_DIR/$SHAPE_TYPE --model_dir $MODEL_DIR --shape_type $SHAPE_TYPE --saved_model_dir $SAVED_MODEL_DIR
done
