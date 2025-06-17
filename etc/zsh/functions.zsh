# ~/.config/zsh/functions.zsh 

# directory creation and navigation functions
mkcd() {
    local dir="$*"
    mkdir -p "$dir" && cd "$dir"
}

mkcp() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] || mkdir -p "$dir" && cp -r "$@"
}

mkmv() {
    local dir="$2"
    local tmp="$2"; tmp="${tmp: -1}"
    [ "$tmp" != "/" ] && dir="$(dirname "$2")"
    [ -d "$dir" ] || mkdir -p "$dir" && mv "$@"
}

# image processing functions for webdev
png2jpeg() {
    mogrify -format jpg -strip *.png
}

pngResize() {
    for file in *.png; do
        mogrify -filter Triangle -define filter:support=2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB "$file"
    done
}

png2favicon() {
    convert -resize x16 -gravity center -crop 16x16+0+0 favicon.png -flatten -colors 256 -background transparent favicon.ico
}

convert_images_to_webp() {
    if [ $# -ne 2 ]; then
        echo "Usage: convert_images_to_webp <source_directory> <destination_directory>"
        return 1
    fi

    local src_dir=$1
    local dest_dir=$2

    if [ ! -d "$src_dir" ]; then
        echo "Source directory not found: $src_dir"
        return 1
    fi

    if [ ! -d "$dest_dir" ]; then
        echo "Creating destination directory: $dest_dir"
        mkdir -p "$dest_dir"
    fi

    for img in "$src_dir"/*; do
        if [ -f "$img" ]; then
            local base_name=$(basename "$img")
            local output_path="$dest_dir/${base_name%.*}.webp"
            echo "Converting $img to $output_path"
            magick convert "$img" -quality 10 "$output_path"
        fi
    done

    echo "Conversion complete."
}

convert_images_to_png() {
    if [ $# -ne 2 ]; then
        echo "Usage: convert_images_to_png <source_directory> <destination_directory>"
        return 1
    fi

    local src_dir=$1
    local dest_dir=$2

    if [ ! -d "$src_dir" ]; then
        echo "Source directory not found: $src_dir"
        return 1
    fi

    if [ ! -d "$dest_dir" ]; then
        echo "Creating destination directory: $dest_dir"
        mkdir -p "$dest_dir"
    fi

    for img in "$src_dir"/*; do
        if [ -f "$img" ]; then
            local base_name=$(basename "$img")
            local output_path="$dest_dir/${base_name%.*}.png"
            echo "Converting $img to $output_path"
            magick convert "$img" -quality 50 "$output_path"
        fi
    done

    echo "Conversion complete."
}

convert_images_to_jpg() {
    if [ $# -ne 2 ]; then
        echo "Usage: convert_images_to_jpg <source_directory> <destination_directory>"
        return 1
    fi

    local src_dir=$1
    local dest_dir=$2

    if [ ! -d "$src_dir" ]; then
        echo "Source directory not found: $src_dir"
        return 1
    fi

    if [ ! -d "$dest_dir" ]; then
        echo "Creating destination directory: $dest_dir"
        mkdir -p "$dest_dir"
    fi

    for img in "$src_dir"/*; do
        if [ -f "$img" ]; then
            local base_name=$(basename "$img")
            local output_path="$dest_dir/${base_name%.*}.jpg"
            echo "Converting $img to $output_path"
            magick convert "$img" -quality 100 "$output_path"
        fi
    done

    echo "Conversion complete."
}

strip_images() {
    if [ $# -ne 2 ]; then
        echo "Usage: strip_images <source_directory> <destination_directory>"
        return 1
    fi

    local src_dir=$1
    local dest_dir=$2

    if [ ! -d "$src_dir" ]; then
        echo "Source directory not found: $src_dir"
        return 1
    fi

    if [ ! -d "$dest_dir" ]; then
        echo "Creating destination directory: $dest_dir"
        mkdir -p "$dest_dir"
    fi

    for img in "$src_dir"/*; do
        if [ -f "$img" ]; then
            local base_name=$(basename "$img")
            local output_path="$dest_dir/${base_name%.*}.webp"
            echo "Converting $img to $output_path"
            magick convert "$img" -strip "$output_path"
        fi
    done

    echo "Conversion complete."
}

# video conversion function
mov2mp4() {
    if [ -z "$1" ]; then
        echo "Please specify a .mov file to convert."
        return 1
    fi

    local input_file=$1
    local output_file="${input_file%.*}.mp4"

    ffmpeg -i "$input_file" -map_metadata -1 -c:v copy -c:a copy "$output_file"
}

# webdev placeholder generation
generate_placeholders() {
    setopt localoptions nullglob
    local img
    for img in *.{jpeg,jpg,png,webp}; do
        convert "$img" -resize 60x60 -blur 0x8 -quality 10 "placeholders/${img%.*}.jpg"
    done
    unsetopt nullglob
    echo "Placeholder images have been generated in the 'placeholders' directory."
}
