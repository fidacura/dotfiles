# ~/.config/fish/functions/media.fish

# directory creation and navigation functions
function mkcd
    mkdir -p $argv; and cd $argv
end

function mkcp
    set -l target $argv[-1]
    set -l dir (dirname $target)
    if test ! -d $dir
        mkdir -p $dir
    end
    cp -r $argv
end

function mkmv
    set -l target $argv[-1]
    set -l dir (dirname $target)
    if test ! -d $dir
        mkdir -p $dir
    end
    mv $argv
end

# image processing functions for webdev
function png2jpeg
    if not command -q mogrify
        echo "Error: imagemagick not installed"
        return 1
    end
    mogrify -format jpg -strip *.png
    echo "Converted all PNG files to JPEG format"
end

function pngResize
    if not command -q mogrify
        echo "Error: imagemagick not installed"
        return 1
    end
    
    for file in *.png
        if test -f $file
            mogrify -filter Triangle \
                -define filter:support=2 \
                -unsharp 0.25x0.08+8.3+0.045 \
                -dither None \
                -posterize 136 \
                -quality 82 \
                -define png:compression-filter=5 \
                -define png:compression-level=9 \
                -define png:compression-strategy=1 \
                -define png:exclude-chunk=all \
                -interlace none \
                -colorspace sRGB $file
        end
    end
    echo "Optimized all PNG files for web"
end

function png2favicon
    if not command -q convert
        echo "Error: imagemagick not installed"
        return 1
    end
    
    if not test -f favicon.png
        echo "Error: favicon.png not found"
        return 1
    end
    
    convert -resize x16 \
        -gravity center \
        -crop 16x16+0+0 \
        favicon.png \
        -flatten \
        -colors 256 \
        -background transparent \
        favicon.ico
    
    echo "Created favicon.ico from favicon.png"
end

function convert_images_to_webp
    if test (count $argv) -ne 2
        echo "Usage: convert_images_to_webp <source_directory> <destination_directory>"
        return 1
    end
    
    set -l src_dir $argv[1]
    set -l dest_dir $argv[2]
    
    if not test -d $src_dir
        echo "Error: Source directory not found: $src_dir"
        return 1
    end
    
    if not test -d $dest_dir
        echo "Creating destination directory: $dest_dir"
        mkdir -p $dest_dir
    end
    
    if not command -q magick
        echo "Error: imagemagick not installed"
        return 1
    end
    
    for img in $src_dir/*
        if test -f $img
            set -l base_name (basename $img)
            set -l name_without_ext (string replace -r '\.[^.]*$' '' $base_name)
            set -l output_path "$dest_dir/$name_without_ext.webp"
            echo "Converting $img to $output_path"
            magick convert $img -quality 10 $output_path
        end
    end
    
    echo "WebP conversion complete."
end

function convert_images_to_png
    if test (count $argv) -ne 2
        echo "Usage: convert_images_to_png <source_directory> <destination_directory>"
        return 1
    end
    
    set -l src_dir $argv[1]
    set -l dest_dir $argv[2]
    
    if not test -d $src_dir
        echo "Error: Source directory not found: $src_dir"
        return 1
    end
    
    if not test -d $dest_dir
        echo "Creating destination directory: $dest_dir"
        mkdir -p $dest_dir
    end
    
    if not command -q magick
        echo "Error: imagemagick not installed"
        return 1
    end
    
    for img in $src_dir/*
        if test -f $img
            set -l base_name (basename $img)
            set -l name_without_ext (string replace -r '\.[^.]*$' '' $base_name)
            set -l output_path "$dest_dir/$name_without_ext.png"
            echo "Converting $img to $output_path"
            magick convert $img -quality 50 $output_path
        end
    end
    
    echo "PNG conversion complete."
end

function convert_images_to_jpg
    if test (count $argv) -ne 2
        echo "Usage: convert_images_to_jpg <source_directory> <destination_directory>"
        return 1
    end
    
    set -l src_dir $argv[1]
    set -l dest_dir $argv[2]
    
    if not test -d $src_dir
        echo "Error: Source directory not found: $src_dir"
        return 1
    end
    
    if not test -d $dest_dir
        echo "Creating destination directory: $dest_dir"
        mkdir -p $dest_dir
    end
    
    if not command -q magick
        echo "Error: imagemagick not installed"
        return 1
    end
    
    for img in $src_dir/*
        if test -f $img
            set -l base_name (basename $img)
            set -l name_without_ext (string replace -r '\.[^.]*$' '' $base_name)
            set -l output_path "$dest_dir/$name_without_ext.jpg"
            echo "Converting $img to $output_path"
            magick convert $img -quality 100 $output_path
        end
    end
    
    echo "JPG conversion complete."
end

function strip_images
    if test (count $argv) -ne 2
        echo "Usage: strip_images <source_directory> <destination_directory>"
        return 1
    end
    
    set -l src_dir $argv[1]
    set -l dest_dir $argv[2]
    
    if not test -d $src_dir
        echo "Error: Source directory not found: $src_dir"
        return 1
    end
    
    if not test -d $dest_dir
        echo "Creating destination directory: $dest_dir"
        mkdir -p $dest_dir
    end
    
    if not command -q magick
        echo "Error: imagemagick not installed"
        return 1
    end
    
    for img in $src_dir/*
        if test -f $img
            set -l base_name (basename $img)
            set -l name_without_ext (string replace -r '\.[^.]*$' '' $base_name)
            set -l output_path "$dest_dir/$name_without_ext.webp"
            echo "Stripping metadata from $img to $output_path"
            magick convert $img -strip $output_path
        end
    end
    
    echo "Image metadata stripping complete."
end

# video conversion function
function mov2mp4
    if test (count $argv) -eq 0
        echo "Usage: mov2mp4 <input_file.mov>"
        return 1
    end
    
    if not command -q ffmpeg
        echo "Error: ffmpeg not installed"
        return 1
    end
    
    set -l input_file $argv[1]
    
    if not test -f $input_file
        echo "Error: Input file not found: $input_file"
        return 1
    end
    
    set -l name_without_ext (string replace -r '\.[^.]*$' '' $input_file)
    set -l output_file "$name_without_ext.mp4"
    
    echo "Converting $input_file to $output_file"
    ffmpeg -i $input_file -map_metadata -1 -c:v copy -c:a copy $output_file
    
    if test $status -eq 0
        echo "Conversion successful: $output_file"
    else
        echo "Conversion failed"
        return 1
    end
end

# webdev placeholder generation
function generate_placeholders
    if not command -q convert
        echo "Error: imagemagick not installed"
        return 1
    end
    
    # create placeholders directory if it doesn't exist
    if not test -d placeholders
        mkdir -p placeholders
    end
    
    set -l image_files (find . -maxdepth 1 -type f \( -name "*.jpeg" -o -name "*.jpg" -o -name "*.png" -o -name "*.webp" \))
    
    if test (count $image_files) -eq 0
        echo "No image files found in current directory"
        return 1
    end
    
    for img in $image_files
        set -l base_name (basename $img)
        set -l name_without_ext (string replace -r '\.[^.]*$' '' $base_name)
        set -l output_path "placeholders/$name_without_ext.jpg"
        
        echo "Generating placeholder for $img"
        convert $img -resize 60x60 -blur 0x8 -quality 10 $output_path
    end
    
    echo "Placeholder images generated in 'placeholders' directory"
end

# start local web server
function server
    set -l port 9080
    if test (count $argv) -gt 0
        set port $argv[1]
    end
    
    echo "Starting server on http://localhost:$port/"
    
    if command -q python3
        python3 -m http.server $port
    else if command -q python
        python -m SimpleHTTPServer $port
    else
        echo "Error: Python not found"
        return 1
    end
end