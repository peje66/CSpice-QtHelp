function ltrim(s) { sub(/^[ \t]+/, "", s); return s }
function rtrim(s) { sub(/[ \t]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }
BEGIN {
    keywords = 0;
    pre = 0;
}

/<h4><a name="Keywords">Keywords<\/a><\/h4>/ {
    keywords = 1;
    next;
}

/<PRE>/ {
    if (keywords) {
        pre = 1;
        next;
    }
}

/<\/PRE>/ {
    keywords = 0;
    pre = 0;
    next;
}

/^ *$/ {
    next;
}

{
    if(keywords && pre) {
        split($0,array,",");
        for(i in array) {
            print "<keyword name=\"" trim(array[i]) "\" ref=\"" FILENAME "\"/>";
        }
    }
}
