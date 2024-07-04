#!/bin/bash

# Function to generate directory index
generate_index() {
    local dir=$1
    local output_file=$2
    local parent_dir=$(basename "$dir")

    # Skip the 'assets' directory
    if [[ "$parent_dir" == "assets" ]]; then
        return
    fi

    echo "<!DOCTYPE html>" > "$output_file"
    echo "<html lang=\"en\">" >> "$output_file"
    echo "<head>" >> "$output_file"
    echo "    <meta charset=\"UTF-8\">" >> "$output_file"
    echo "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> "$output_file"
    local current_dir=$parent_dir
    echo "    <title>$current_dir</title>" >> "$output_file"
    echo "</head>" >> "$output_file"
    echo "<body>" >> "$output_file"
    # Get the current directory name
    echo "    <h1>$current_dir</h1>" >> "$output_file"
    echo "    <ul>" >> "$output_file"

    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            subdir=$(basename "$file")
#            为什么这块代码放到递归方法下面就不会执行了呢？
            if [[ "$subdir" != "assets" && "$subdir" != "index.html" && "$subdir" != "cdn-cgi"&& "$subdir" != "static"&& "$subdir" != "gen.sh" ]]; then

                echo "        <li><a href=\"$subdir/index.html\">$subdir/</a></li>" >> "$output_file"
            fi
            generate_index "$file" "$file/index.html"


        elif [[ "$parent_dir" != "assets" && "$parent_dir" != "cdn-cgi" ]]; then
            filename=$(basename "$file")
            if [[ "$filename" != "index.html"   && "$filename" != ".idea" && "$filename" != "README.md"&& "$filename" != "gen.sh" ]]; then
                echo "        <li><a href=\"$filename\">$filename</a></li>" >> "$output_file"
            fi
        fi
    done

    echo "    </ul>" >> "$output_file"
    echo "</body>" >> "$output_file"
    echo "</html>" >> "$output_file"
}




# Generate index for current directory
generate_index "../lyy720301.github.io" "index.html"
