#! /bin/bash

INPUT_FILE=${1}
INPUT_FILE_CONTENT_START_LINE=${2:-2}
URL_COLUMN_IDX=${3:-19}
BOOK_TITLE_IDX=${4:-1}
BOOK_AUTHOR_IDX=${5:-2}
BOOK_YEAR_IDX=${6:-5}


download_pdf() {
    url=${1}
    title=$(sanitize_string "${2}")
    author=$(sanitize_string "${3}")
    year=$(sanitize_string "${4}")
    file_name=isbn_$(echo "${url}" | awk -F"=" '{print $NF}')
    curl -L -o ${file_name}-${title}-${author}-${year}.pdf $(parse_url_pdf ${url})
}

parse_url_pdf() {
    url=${1}
    echo $(curl -Ls -o /dev/null -w %{url_effective} "${url}" | sed -E 's,/book/,/content/pdf/,').pdf
}

sanitize_string() {
  input_str="${1}"
  echo $input_str | tr -s " .," "_"
}

parse_download_links() {
    input_file="${1}"
    input_file_content_start_line="${2}"
    url_column_index="${3}"
    title_idx="${4}"
    author_idx="${5}"
    year_idx="${6}"

    tail -n +${input_file_content_start_line} "${input_file}" | awk -F';' "{print \$${url_column_index}\";\"\$${title_idx}\";\"\$${author_idx}\";\"\$${year_idx}}"
}

main() {
  parse_download_links "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"
    for var_packed in "$(parse_download_links "${1}" "${2}" "${3}" "${4}" "${5}" "${6}")"; do
        IFS=";" read url title author year <<< "${var_packed}"
        echo $var_packed
        echo "VARS" $url, $title, $author, $year
        download_pdf "${url}" "${title}" "${author}" "${year}"
    done
}


${__SOURCED__:+return} # to not run code after this line during shellspec tests

main "${INPUT_FILE}" "${INPUT_FILE_CONTENT_START_LINE}" "${URL_COLUMN_IDX}" "${BOOK_TITLE_IDX}" "${BOOK_AUTHOR_IDX}" "${BOOK_YEAR_IDX}"
