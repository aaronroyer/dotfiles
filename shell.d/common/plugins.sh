
PLUGINS_DIR=$COMMON_DIR/plugins

for plugin in $(ls $PLUGINS_DIR); do
  shy load "$PLUGINS_DIR/$plugin"
done

unset PLUGINS_DIR
