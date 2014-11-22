tree() {
    find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}
