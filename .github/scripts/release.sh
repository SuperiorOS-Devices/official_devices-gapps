#!/bin/sh
#
# Copyright (C) 2021 Ashwin DS <astroashwin@outlook.com>
#
# Part of SuperiorOS <https://github.com/SuperiorOS>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation;
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

if [ -f "noupdates.txt" ]; then
    exit
fi

RELEASE_MESSAGE=$(cat tag.txt)

for file in ./*.zip; do
    # Check file size
    file_size=$(stat -c%s "$file")
    max_file_size=2147483648  # 2 GB

    if [ "$file_size" -gt "$max_file_size" ]; then
        echo "Skipping $file - File size exceeds the limit"
        continue
    fi

    # Upload the file using gh
    gh release create "$RELEASE_MESSAGE" "$file" -F release_notes.txt -t "New Superior OS Update[Gapps]"
done