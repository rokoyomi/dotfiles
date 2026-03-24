list_formatted() {
    for i in $(ls $WPDIR/*.* | sed 's/ /@/g'); do
        TEMP=$(echo $i | sed 's/@/ /g')
        FILEPATH=$TEMP
        FILENAME=$(echo $TEMP | grep -Po "[0-9a-zA-Z\-_ ]+(?=\.)")
        printf 'img:%s:text:%s\n' "$FILEPATH" "$FILENAME";
    done
}

if [ "$1" != "" ]; then
    matugen image $1;
    exit 0;
fi

if [ "$(set | grep WPDIR)" == "" ]; then
    WPDIR=~/.config/wallpapers
fi

SELECTED=$(
    list_formatted |
    wofi --dmenu --conf ~/.config/theme_switcher/scripts/theme-switcher-config |
    cut -s -d : -f 2)

if [ -n "$SELECTED" ]; then
    matugen image "$SELECTED" >> ~/.log/matugen.log
fi
